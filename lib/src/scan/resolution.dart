/// Pure scan resolution: data in, [ScanOutcome] out. No I/O, so every
/// branch is unit-testable (see docs/resolution-flow.md).
library;

import '../catalog/models.dart';
import 'label_matcher.dart';
import 'scan_outcome.dart';

final RegExp _digitsOnly = RegExp(r'^\d+$');

/// Codes to look up for a raw scanner value. Codes are stored as plain
/// strings without GS1 validation, but a 12-digit UPC-A and the same code
/// as 13-digit EAN-13 with a leading zero are one physical barcode, and
/// scanners report either form. Empty set means nothing usable was read.
Set<String> barcodeLookupKeys(String raw) {
  final code = raw.trim();
  if (code.isEmpty) return const {};
  if (_digitsOnly.hasMatch(code)) {
    if (code.length == 12) return {code, '0$code'};
    if (code.length == 13 && code.startsWith('0')) {
      return {code, code.substring(1)};
    }
  }
  return {code};
}

/// Resolves the rows found for one barcode.
///
/// [vintagesByWine] must contain the verified vintages of every wine in
/// [hits] (newest first); it is used when a row has no vintage.
ScanOutcome resolveBarcode(
  List<BarcodeHit> hits,
  Map<int, List<VintageOption>> vintagesByWine,
) {
  // Rows that differ only by bottle size, or list several vintages of the
  // same wine, are one candidate, not a collision between wines.
  final byWine = <int, List<BarcodeHit>>{};
  for (final hit in hits) {
    (byWine[hit.wine.id] ??= []).add(hit);
  }

  final candidates = <WineCandidate>[];
  for (final group in byWine.values) {
    final wine = group.first.wine;
    final next = _nextForBarcodeWine(
      wine,
      group,
      vintagesByWine[wine.id] ?? const [],
    );
    if (next != null) candidates.add(WineCandidate(wine: wine, next: next));
  }

  if (candidates.isEmpty) return const NotInCatalogue(ScanSource.barcode);
  if (candidates.length == 1) return candidates.single.next;
  candidates.sort(_byWineryThenName);
  return ChooseWine(source: ScanSource.barcode, candidates: candidates);
}

/// Null when the rows point at nothing showable (a wine with no verified
/// vintages; the build script rejects that, this is only a safety net).
ScanOutcome? _nextForBarcodeWine(
  WineSummary wine,
  List<BarcodeHit> rows,
  List<VintageOption> allVintages,
) {
  final pinned = {for (final row in rows) row.vintageId};
  if (pinned.contains(null)) {
    // The code identifies the product: ask for the harvest year.
    if (allVintages.isEmpty) return null;
    return ChooseVintage(wine: wine, vintages: allVintages);
  }
  final options = allVintages.where((v) => pinned.contains(v.id)).toList();
  if (options.isEmpty) return null;
  if (options.length == 1) return ShowVintage(options.single.id);
  return ChooseVintage(wine: wine, vintages: options);
}

/// Resolves OCR text read from a label. Never auto-selects a wine: any
/// match goes through [ChooseWine]. A year read from the label that exists
/// among a candidate's vintages is preselected in its picker.
ScanOutcome resolveLabel(String ocrText, LabelMatcher matcher) {
  final matches = matcher.match(ocrText);
  if (matches.isEmpty) return const NotInCatalogue(ScanSource.label);

  final years = extractYears(ocrText);
  return ChooseWine(
    source: ScanSource.label,
    candidates: [
      for (final m in matches)
        WineCandidate(
          wine: m.entry.wine,
          score: m.score,
          next: ChooseVintage(
            wine: m.entry.wine,
            vintages: m.entry.vintages,
            preselectedVintageId: _preselect(m.entry.vintages, years),
          ),
        ),
    ],
  );
}

/// The vintage whose year was read, or null when none or several match
/// (e.g. a founding year and a harvest year both printed on the label).
int? _preselect(List<VintageOption> vintages, Set<int> years) {
  final matching = vintages.where((v) => years.contains(v.year)).toList();
  return matching.length == 1 ? matching.single.id : null;
}

int _byWineryThenName(WineCandidate a, WineCandidate b) {
  final byWinery = a.wine.wineryName.compareTo(b.wine.wineryName);
  return byWinery != 0 ? byWinery : a.wine.name.compareTo(b.wine.name);
}
