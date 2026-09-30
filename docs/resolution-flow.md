# Scan resolution flow

The camera screen hands raw input to `ScanService`; it returns a `ScanOutcome`
that says which screen to show and with which data. The decision itself lives
in pure functions in `lib/src/scan/resolution.dart` (no I/O, fully unit tested).

```
camera ──barcode rawValue──▶ ScanService.resolveBarcode ─┐
   │  (no barcode after N s)                              ├─▶ ScanOutcome
   └──OCR text──────────────▶ ScanService.resolveLabel ──┘
```

## Outcomes → screens

| Outcome          | Screen                         | Next step                                              |
|------------------|--------------------------------|--------------------------------------------------------|
| `ShowVintage`    | Result                         | `CatalogRepository.vintageDetails(id, language:)`, then `RecentScansStore.record(id)` |
| `ChooseVintage`  | Vintage picker                 | User picks → `ShowVintage(option.id)`. Highlight `preselectedVintageId` if set |
| `ChooseWine`     | Candidate list                 | User taps → show `candidate.next` (already resolved)   |
| `NotInCatalogue` | "Not in our catalogue yet"     | Request button; if `canTryLabel`, offer label scan     |

`ScanOutcome` is a sealed class, so a Dart `switch` over it is checked for
exhaustiveness by the compiler.

## Barcode

1. `barcodeLookupKeys`: trim; for a numeric code also look up the UPC-A /
   EAN-13 twin (12 digits ↔ `0` + 12 digits). No GS1 checksum validation.
2. Rows are grouped by wine (rows that differ only by bottle size, or list
   several vintages of one wine, are not a collision).
3. Per wine:
   - any row with NULL vintage → `ChooseVintage` with all verified vintages;
   - exactly one pinned vintage → `ShowVintage`;
   - several pinned vintages → `ChooseVintage` limited to those;
   - nothing showable (no verified vintages) → dropped.
4. 0 wines → `NotInCatalogue(barcode)`; 1 wine → its next step directly;
   more → `ChooseWine(barcode)` sorted by winery, then wine name.

## Label (OCR)

1. Normalize: lowercase, strip diacritics (ă â î ș ț, cedilla ş ţ, and common
   French/German accents), non-alphanumerics to spaces.
2. Score each wine: `wineryWeight × winery score + (1 − wineryWeight) × wine
   score`. A name's score is the mean, over its words, of the best
   Levenshtein similarity to any label word (or two adjacent label words
   joined, to survive OCR splitting a word).
3. Keep scores ≥ `threshold` (0.75), best first, at most `maxCandidates` (3).
4. None → `NotInCatalogue(label)`. Otherwise **always** `ChooseWine(label)`,
   even with one candidate: the user confirms.
5. Each candidate's next step is `ChooseVintage`. Years 19xx/20xx read on
   the label that match exactly one verified vintage are preselected;
   none or several → nothing preselected.

All tuning values are in `LabelMatchConfig`; tune them on the real bottles.

## Not in this layer

- The "no barcode after a few seconds → offer label scan" timeout belongs to
  the camera screen (it depends on the camera plugin's stream). Tune on real
  bottles.
- Camera (`mobile_scanner`, linear barcode formats only so a QR code is not
  read first) and OCR (`google_mlkit_text_recognition`, Latin script) are
  wired in the developer test screen `lib/app/scan_test_screen.dart`; they
  only produce a string for `ScanService`.
