# Decision log

Confirmed by Paul (project context v2, 2026-09-29):

| Date | Decision |
|---|---|
| 2026-09-29 | Flutter, one codebase for iOS and Android |
| 2026-09-29 | Barcode (EAN-13) first, label OCR as fallback |
| 2026-09-29 | Codes stored as plain strings, no GS1 validation |
| 2026-09-29 | Bundled SQLite snapshot, offline lookups, no backend |
| 2026-09-29 | Barcode `code` indexed, not unique (collisions representable); `vintage_id` nullable |
| 2026-09-29 | Translations in per-entity tables keyed by language; prototype fills `ro` only |
| 2026-09-29 | Sensory notes and pairings stored per vintage |
| 2026-09-29 | OCR never auto-selects a wine; top 2–3 candidates above a threshold |
| 2026-09-29 | Vintage picker lists only verified vintages |
| 2026-09-29 | No accounts, no ratings or scores, no personal data, no analytics in the prototype |
| 2026-09-29 | Recent scans stored on the device only |
| 2026-09-29 | UI strings in localization files from day one |
| 2026-09-29 | Stack: drift, mobile_scanner, google_mlkit_text_recognition |
| 2026-09-30 | Data build script in Dart, reusing the app's schema and normalizer |

Implementation choices (2026-09-30, open to change):

| Decision | Why |
|---|---|
| Logic layer is pure Dart (no Flutter imports) in `lib/src`, exported via `lib/gustaro_core.dart` | The build script and tests run it without Flutter; the UI depends on one import |
| Resolution returns a sealed `ScanOutcome`; wine candidates carry their resolved next step | The UI is a plain `switch`; no second lookup after a tap |
| Barcode rows grouped by wine before counting | The same wine in two bottle sizes or with several listed vintages is not a collision |
| 12-digit UPC-A and `0`-prefixed EAN-13 treated as the same code | Same physical barcode; scanners report either form |
| OCR year match preselects in the picker, user still confirms | Consistent with "never auto-select" and protects against misread digits |
| Several matching years on one label → nothing preselected | Founding year and harvest year can both be printed |
| Label matching: Levenshtein token similarity, winery and wine name weighted 50/50, threshold 0.75 | Simple, no dependencies, tunable in `LabelMatchConfig` |
| Catalogue IDs assigned in the spreadsheet and stable forever | Recent scans reference them across catalogue updates |
| Recent scans in a separate on-device DB, newest 50 | A catalogue swap must not touch user data |
| Tech specs as nullable numbers with units in column names (`acidity_g_l`) | Not every winemaker publishes every value |
| Grape varieties and food pairings as JSON string arrays | Ordered lists without extra join tables; enough for the prototype |
| Developer scan test screen before the real UI, strings not localized | Test real bottles now; it is thrown away when the designed UI lands |
| Bundled catalogue copied from the app bundle on every launch; app refuses a snapshot with another schema version | Simple for the prototype; fail closed instead of showing wrong data |
| Build script fails on any error and writes via temp file + rename | Never ship a half-built or wrong catalogue |
| Barcode scanning limited to linear formats | Bottles often carry a QR code next to the EAN |

Known risks found while building (2026-09-30):

- ML Kit text recognition has no Cyrillic model (scripts: Latin, Chinese,
  Devanagari, Japanese, Korean). Russian-only labels cannot be read.
- ML Kit ships a Google data-transport SDK on iOS that reports ML Kit usage
  metrics to Google. Verify what is sent before production (privacy promise,
  App Store privacy label).
- The ML Kit Flutter plugins do not support Swift Package Manager yet; Flutter
  warns this will become an error in a future version.
- ML Kit does not run on the iOS Simulator on Apple Silicon; test on devices.
