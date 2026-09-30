import 'package:drift/drift.dart' hide isNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:gustaro/src/catalog/catalog_database.dart';
import 'package:gustaro/src/catalog/catalog_repository.dart';

import '../support/fixture_catalog.dart';

void main() {
  late CatalogDatabase db;
  late CatalogRepository repo;

  setUp(() async {
    db = await openFixtureCatalog();
    repo = CatalogRepository(db);
  });
  tearDown(() => db.close());

  test('barcode code is not unique: a collision returns every row', () async {
    final hits = await repo.findBarcodes({Fixture.codeCollision});
    expect(hits.map((h) => h.wine.id), [11, 20]);
    expect(hits.first.wine.wineryName, 'Crama Țărăncuța');
  });

  test('barcode code column is indexed', () async {
    final plan = await db
        .customSelect(
          "EXPLAIN QUERY PLAN SELECT * FROM barcode WHERE code = 'x'",
        )
        .get();
    expect(
      plan.map((r) => r.read<String>('detail')).join(),
      contains('barcode_code_idx'),
    );
  });

  test(
    'vintagesOf returns newest first and omits wines without vintages',
    () async {
      final vintages = await repo.vintagesOf({10, 40});
      expect(vintages.keys, [10]);
      expect(vintages[10]!.map((v) => v.year), [2021, 2020, 2019]);
    },
  );

  test('labelIndex excludes wines without verified vintages', () async {
    final index = await repo.labelIndex();
    expect(index.map((e) => e.wine.id), [10, 11, 20, 21, 30]);
  });

  test(
    'vintageDetails returns specs and texts in the requested language',
    () async {
      final d = (await repo.vintageDetails(102, language: 'en'))!;
      expect(d.year, 2020);
      expect(d.wine.name, 'Fetească Neagră');
      expect(d.region, 'Codru');
      expect(d.grapeVarieties, ['Fetească Neagră']);
      expect(d.abv, 13.5);
      expect(d.tanninsGL, isNull);
      expect(d.language, 'en');
      expect(d.sensoryNotes, 'Sour cherry, dried plum.');
      expect(d.foodPairings, ['Lamb', 'Aged cheese']);
      // No English wine description yet: falls back to Romanian.
      expect(d.description, 'Vin roșu sec.');
    },
  );

  test(
    'vintageDetails falls back to Romanian when a language is missing',
    () async {
      final d = (await repo.vintageDetails(102, language: 'ru'))!;
      expect(d.language, 'ro');
      expect(d.foodPairings, ['Miel', 'Brânză maturată']);
    },
  );

  test('vintageDetails is null for an unknown vintage', () async {
    expect(await repo.vintageDetails(9999), isNull);
  });

  test('vintageSummaries skips IDs no longer in the catalogue', () async {
    final summaries = await repo.vintageSummaries({102, 9999});
    expect(summaries.keys, [102]);
    expect(summaries[102]!.wine.wineryName, 'Crama Țărăncuța');
  });

  test('foreign keys are enforced', () async {
    expect(
      () => db
          .into(db.vintageTable)
          .insert(
            VintageTableCompanion.insert(
              id: const Value(999),
              wineId: 12345,
              year: 2020,
            ),
          ),
      throwsA(anything),
    );
  });
}
