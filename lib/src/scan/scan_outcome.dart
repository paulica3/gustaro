import '../catalog/models.dart';

enum ScanSource { barcode, label }

/// What the UI should show next. Exhaustive: `switch` over it and the
/// compiler guarantees every screen is handled.
sealed class ScanOutcome {
  const ScanOutcome();
}

/// Result screen. Load the content with `CatalogRepository.vintageDetails`.
final class ShowVintage extends ScanOutcome {
  const ShowVintage(this.vintageId);

  final int vintageId;
}

/// Vintage picker. Only verified vintages are listed, newest first.
/// [preselectedVintageId] is set when OCR read a year that exists in
/// [vintages]; the user still confirms.
final class ChooseVintage extends ScanOutcome {
  const ChooseVintage({
    required this.wine,
    required this.vintages,
    this.preselectedVintageId,
  });

  final WineSummary wine;
  final List<VintageOption> vintages;
  final int? preselectedVintageId;
}

/// Short list of wines: a barcode collision, or label (OCR) candidates.
/// Label candidates are never auto-selected, even when there is only one.
final class ChooseWine extends ScanOutcome {
  const ChooseWine({required this.source, required this.candidates});

  final ScanSource source;
  final List<WineCandidate> candidates;
}

/// "Not in our catalogue yet" screen with the request-this-wine button.
final class NotInCatalogue extends ScanOutcome {
  const NotInCatalogue(this.source);

  final ScanSource source;

  /// After a barcode miss the screen offers to scan the label instead.
  bool get canTryLabel => source == ScanSource.barcode;
}

/// One entry of [ChooseWine]. Tapping it goes to [next], which is already
/// resolved, so no further lookup is needed.
final class WineCandidate {
  const WineCandidate({required this.wine, required this.next, this.score});

  final WineSummary wine;

  /// Either [ShowVintage] or [ChooseVintage].
  final ScanOutcome next;

  /// Label match confidence 0..1; null for barcode collisions.
  final double? score;
}
