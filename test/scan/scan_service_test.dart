import 'package:flutter_test/flutter_test.dart';
import 'package:gustaro/gustaro_core.dart';

import '../support/fixture_catalog.dart';

/// End-to-end through the real (in-memory) database.
void main() {
  late CatalogDatabase db;
  late ScanService scanner;

  setUp(() async {
    db = await openFixtureCatalog();
    scanner = ScanService(CatalogRepository(db));
  });
  tearDown(() => db.close());

  test('barcode with vintage -> result', () async {
    expect(
      await scanner.resolveBarcode(Fixture.codeWithVintage),
      isA<ShowVintage>().having((o) => o.vintageId, 'vintageId', 102),
    );
  });

  test('product barcode -> vintage picker', () async {
    expect(
      await scanner.resolveBarcode(Fixture.codeProductOnly),
      isA<ChooseVintage>().having((o) => o.vintages.map((v) => v.id), 'ids', [
        103,
        102,
        101,
      ]),
    );
  });

  test('collision -> wine list', () async {
    expect(
      await scanner.resolveBarcode(Fixture.codeCollision),
      isA<ChooseWine>(),
    );
  });

  test('same wine in two bottle sizes -> result', () async {
    expect(
      await scanner.resolveBarcode(Fixture.codeTwoBottleSizes),
      isA<ShowVintage>(),
    );
  });

  test('same wine, two pinned vintages -> picker of those two', () async {
    expect(
      await scanner.resolveBarcode(Fixture.codeSameWineTwoVintages),
      isA<ChooseVintage>().having(
        (o) => o.vintages.map((v) => v.year),
        'years',
        [2019, 2018],
      ),
    );
  });

  test('stored UPC-A is found when the scanner reports EAN-13', () async {
    expect(
      await scanner.resolveBarcode('0${Fixture.codeUpcA}'),
      isA<ShowVintage>(),
    );
  });

  test('wine without verified vintages -> miss', () async {
    expect(
      await scanner.resolveBarcode(Fixture.codeWineWithoutVintages),
      isA<NotInCatalogue>(),
    );
  });

  test('unknown and empty barcodes -> miss offering label scan', () async {
    for (final raw in [Fixture.codeUnknown, '  ']) {
      expect(
        await scanner.resolveBarcode(raw),
        isA<NotInCatalogue>().having(
          (o) => o.canTryLabel,
          'canTryLabel',
          isTrue,
        ),
      );
    }
  });

  test('label text -> candidates with year preselected', () async {
    final outcome = await scanner.resolveLabel(
      'CASTEL MIREŞTII\nNegru de Mireştii\n2017',
    );
    final first = (outcome as ChooseWine).candidates.first;
    expect(first.wine.id, 30);
    expect((first.next as ChooseVintage).preselectedVintageId, 301);
  });

  test('unmatched label text -> miss', () async {
    expect(
      await scanner.resolveLabel('Merlot\nVin de masă'),
      isA<NotInCatalogue>(),
    );
  });
}
