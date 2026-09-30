import 'package:flutter_test/flutter_test.dart';
import 'package:gustaro/src/catalog/models.dart';
import 'package:gustaro/src/scan/label_matcher.dart';
import 'package:gustaro/src/scan/resolution.dart';
import 'package:gustaro/src/scan/scan_outcome.dart';

const _fnTaraneuta = WineSummary(
  id: 10,
  name: 'Fetească Neagră',
  wineryName: 'Crama Țărăncuța',
  type: WineType.red,
);
const _rnTaraneuta = WineSummary(
  id: 11,
  name: 'Rară Neagră',
  wineryName: 'Crama Țărăncuța',
  type: WineType.red,
);
const _faValenii = WineSummary(
  id: 20,
  name: 'Fetească Albă',
  wineryName: 'Château Vălenii',
  type: WineType.white,
);
const _fnValenii = WineSummary(
  id: 21,
  name: 'Fetească Neagră Rezervă',
  wineryName: 'Château Vălenii',
  type: WineType.red,
);

const _fnVintages = [
  VintageOption(id: 103, year: 2021),
  VintageOption(id: 102, year: 2020),
  VintageOption(id: 101, year: 2019),
];

BarcodeHit _hit(WineSummary wine, int? vintageId, {int? sizeMl}) =>
    BarcodeHit(wine: wine, vintageId: vintageId, bottleSizeMl: sizeMl);

void main() {
  group('barcodeLookupKeys', () {
    test('trims the raw value', () {
      expect(barcodeLookupKeys('  4841000000010\n'), {'4841000000010'});
    });

    test('nothing to look up for an empty read', () {
      expect(barcodeLookupKeys('   '), isEmpty);
    });

    test('12-digit UPC-A also looks up its EAN-13 form', () {
      expect(barcodeLookupKeys('012345678905'), {
        '012345678905',
        '0012345678905',
      });
    });

    test('EAN-13 with leading zero also looks up its UPC-A form', () {
      expect(barcodeLookupKeys('0012345678905'), {
        '0012345678905',
        '012345678905',
      });
    });

    test('non-numeric internal codes are kept as-is', () {
      expect(barcodeLookupKeys('MD-0042'), {'MD-0042'});
    });
  });

  group('resolveBarcode', () {
    test('miss: no rows -> not in catalogue, offering label scan', () {
      final outcome = resolveBarcode(const [], const {});
      expect(
        outcome,
        isA<NotInCatalogue>()
            .having((o) => o.source, 'source', ScanSource.barcode)
            .having((o) => o.canTryLabel, 'canTryLabel', isTrue),
      );
    });

    test('hit with vintage -> result screen', () {
      final outcome = resolveBarcode(
        [_hit(_fnTaraneuta, 102)],
        {10: _fnVintages},
      );
      expect(
        outcome,
        isA<ShowVintage>().having((o) => o.vintageId, 'vintageId', 102),
      );
    });

    test('hit with null vintage -> picker with all verified vintages, none preselected', () {
      final outcome = resolveBarcode(
        [_hit(_fnTaraneuta, null)],
        {10: _fnVintages},
      );
      expect(
        outcome,
        isA<ChooseVintage>()
            .having((o) => o.wine.id, 'wine', 10)
            .having((o) => o.vintages.map((v) => v.year), 'years', [
              2021,
              2020,
              2019,
            ])
            .having((o) => o.preselectedVintageId, 'preselected', isNull),
      );
    });

    test('hit with null vintage but wine has no verified vintages -> miss', () {
      final outcome = resolveBarcode([_hit(_fnTaraneuta, null)], const {});
      expect(outcome, isA<NotInCatalogue>());
    });

    test(
      'collision between wines -> wine list, each with its own next step',
      () {
        final outcome = resolveBarcode(
          [_hit(_rnTaraneuta, 111), _hit(_faValenii, null)],
          {
            11: const [VintageOption(id: 111, year: 2020)],
            20: const [VintageOption(id: 201, year: 2022)],
          },
        );
        expect(
          outcome,
          isA<ChooseWine>().having(
            (o) => o.source,
            'source',
            ScanSource.barcode,
          ),
        );
        final candidates = (outcome as ChooseWine).candidates;
        // Sorted by winery, then name: Château Vălenii before Crama Țărăncuța.
        expect(candidates.map((c) => c.wine.id), [20, 11]);
        expect(candidates.map((c) => c.score), [null, null]);
        expect(candidates[0].next, isA<ChooseVintage>());
        expect(
          candidates[1].next,
          isA<ShowVintage>().having((o) => o.vintageId, 'vintageId', 111),
        );
      },
    );

    test('collision drops a candidate that has nothing to show', () {
      final outcome = resolveBarcode(
        [_hit(_rnTaraneuta, 111), _hit(_faValenii, null)],
        {
          11: const [VintageOption(id: 111, year: 2020)],
        },
      );
      expect(
        outcome,
        isA<ShowVintage>().having((o) => o.vintageId, 'vintageId', 111),
      );
    });

    test('same wine and vintage in two bottle sizes -> straight to result', () {
      final outcome = resolveBarcode(
        [
          _hit(_fnTaraneuta, 102, sizeMl: 750),
          _hit(_fnTaraneuta, 102, sizeMl: 1500),
        ],
        {10: _fnVintages},
      );
      expect(
        outcome,
        isA<ShowVintage>().having((o) => o.vintageId, 'vintageId', 102),
      );
    });

    test(
      'same wine, several pinned vintages -> picker limited to those vintages',
      () {
        final outcome = resolveBarcode(
          [_hit(_fnTaraneuta, 101), _hit(_fnTaraneuta, 103)],
          {10: _fnVintages},
        );
        expect(
          outcome,
          isA<ChooseVintage>().having(
            (o) => o.vintages.map((v) => v.id),
            'ids',
            [103, 101],
          ),
        );
      },
    );

    test(
      'same wine, pinned and product rows mixed -> picker with all vintages',
      () {
        final outcome = resolveBarcode(
          [_hit(_fnTaraneuta, 101), _hit(_fnTaraneuta, null)],
          {10: _fnVintages},
        );
        expect(
          outcome,
          isA<ChooseVintage>().having((o) => o.vintages.length, 'count', 3),
        );
      },
    );
  });

  group('resolveLabel', () {
    final matcher = LabelMatcher([
      const LabelIndexEntry(wine: _fnTaraneuta, vintages: _fnVintages),
      const LabelIndexEntry(
        wine: _rnTaraneuta,
        vintages: [VintageOption(id: 111, year: 2020)],
      ),
      const LabelIndexEntry(
        wine: _faValenii,
        vintages: [VintageOption(id: 201, year: 2022)],
      ),
      const LabelIndexEntry(
        wine: _fnValenii,
        vintages: [
          VintageOption(id: 212, year: 2019),
          VintageOption(id: 211, year: 2018),
        ],
      ),
    ]);

    test('candidates above threshold -> wine list, best first, never auto-selected', () {
      final outcome = resolveLabel(
        'CRAMA ȚĂRĂNCUȚA\nFetească Neagră\nVin roșu sec',
        matcher,
      );
      expect(
        outcome,
        isA<ChooseWine>().having((o) => o.source, 'source', ScanSource.label),
      );
      final candidates = (outcome as ChooseWine).candidates;
      expect(candidates.first.wine.id, 10);
      expect(candidates.first.score, 1.0);
      expect(candidates.length, inInclusiveRange(1, 3));
      for (final c in candidates) {
        expect(
          c.score,
          greaterThanOrEqualTo(const LabelMatchConfig().threshold),
        );
        expect(c.next, isA<ChooseVintage>());
      }
    });

    test('a single strong match is still shown as a list to confirm', () {
      final single = LabelMatcher([
        const LabelIndexEntry(
          wine: _faValenii,
          vintages: [VintageOption(id: 201, year: 2022)],
        ),
      ]);
      final outcome = resolveLabel('Château Vălenii Fetească Albă', single);
      expect(
        outcome,
        isA<ChooseWine>().having(
          (o) => o.candidates.map((c) => c.wine.id),
          'ids',
          [20],
        ),
      );
    });

    test(
      'nothing above threshold -> miss without offering label scan again',
      () {
        final outcome = resolveLabel('Some other winery\nMerlot 2020', matcher);
        expect(
          outcome,
          isA<NotInCatalogue>()
              .having((o) => o.source, 'source', ScanSource.label)
              .having((o) => o.canTryLabel, 'canTryLabel', isFalse),
        );
      },
    );

    test('empty OCR text -> miss', () {
      expect(resolveLabel('', matcher), isA<NotInCatalogue>());
    });

    test('year on the label that exists in vintages -> preselected', () {
      final outcome = resolveLabel(
        'Crama Țărăncuța Fetească Neagră 2020 750 ml 13,5%',
        matcher,
      );
      final next =
          (outcome as ChooseWine).candidates.first.next as ChooseVintage;
      expect(next.preselectedVintageId, 102);
      expect(
        next.vintages.length,
        3,
        reason: 'picker still lists every verified vintage',
      );
    });

    test('year on the label that is not a verified vintage -> picker, nothing preselected', () {
      final outcome = resolveLabel(
        'Crama Țărăncuța Fetească Neagră 2016',
        matcher,
      );
      final next =
          (outcome as ChooseWine).candidates.first.next as ChooseVintage;
      expect(next.preselectedVintageId, isNull);
    });

    test('two readable years that are both vintages -> ambiguous, nothing preselected', () {
      final outcome = resolveLabel(
        'Crama Țărăncuța est. 2019 Fetească Neagră 2021',
        matcher,
      );
      final next =
          (outcome as ChooseWine).candidates.first.next as ChooseVintage;
      expect(next.preselectedVintageId, isNull);
    });

    test(
      'founding year that is not a vintage does not block the harvest year',
      () {
        final outcome = resolveLabel(
          'Crama Țărăncuța din 1998 Fetească Neagră 2021',
          matcher,
        );
        final next =
            (outcome as ChooseWine).candidates.first.next as ChooseVintage;
        expect(next.preselectedVintageId, 103);
      },
    );
  });
}
