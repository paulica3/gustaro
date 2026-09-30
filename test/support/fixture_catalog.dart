import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:gustaro/src/catalog/catalog_database.dart';
import 'package:gustaro/src/catalog/models.dart';

/// Fictional wineries and made-up codes; one barcode per resolution branch.
abstract final class Fixture {
  static const codeWithVintage = '4841000000010';
  static const codeProductOnly = '4841000000027';
  static const codeCollision = '4841000000034';
  static const codeSameWineTwoVintages = '4841000000041';
  static const codeTwoBottleSizes = '4841000000058';
  static const codeUpcA = '012345678905';
  static const codeWineWithoutVintages = '4841000000065';
  static const codeUnknown = '4849999999999';
}

/// In-memory catalogue filled with the fixture data.
Future<CatalogDatabase> openFixtureCatalog() async {
  final db = CatalogDatabase(NativeDatabase.memory());
  await db.batch((b) {
    b.insertAll(db.wineryTable, [
      WineryTableCompanion.insert(
        id: const Value(1),
        name: 'Crama Țărăncuța',
        region: const Value('Codru'),
      ),
      WineryTableCompanion.insert(
        id: const Value(2),
        name: 'Château Vălenii',
        region: const Value('Ștefan Vodă'),
      ),
      WineryTableCompanion.insert(
        id: const Value(3),
        name: 'Castel Mireștii',
        region: const Value('Valul lui Traian'),
      ),
    ]);
    b.insertAll(db.wineTable, [
      _wine(10, 1, 'Fetească Neagră', WineType.red, ['Fetească Neagră']),
      _wine(11, 1, 'Rară Neagră', WineType.red, ['Rară Neagră']),
      _wine(20, 2, 'Fetească Albă', WineType.white, ['Fetească Albă']),
      _wine(21, 2, 'Fetească Neagră Rezervă', WineType.red, [
        'Fetească Neagră',
      ]),
      _wine(30, 3, 'Negru de Mireștii', WineType.red, [
        'Fetească Neagră',
        'Rară Neagră',
        'Cabernet Sauvignon',
      ]),
      _wine(40, 3, 'Viorica', WineType.white, ['Viorica']),
    ]);
    b.insertAll(db.vintageTable, [
      _vintage(101, 10, 2019),
      VintageTableCompanion.insert(
        id: const Value(102),
        wineId: 10,
        year: 2020,
        abv: const Value(13.5),
        acidityGL: const Value(5.8),
        residualSugarGL: const Value(2.1),
      ),
      _vintage(103, 10, 2021),
      _vintage(111, 11, 2020),
      _vintage(201, 20, 2022),
      _vintage(211, 21, 2018),
      _vintage(212, 21, 2019),
      _vintage(301, 30, 2017),
    ]);
    b.insertAll(db.barcodeTable, [
      _barcode(1, Fixture.codeWithVintage, 10, 102),
      _barcode(2, Fixture.codeProductOnly, 10, null),
      _barcode(3, Fixture.codeCollision, 11, 111),
      _barcode(4, Fixture.codeCollision, 20, 201),
      _barcode(5, Fixture.codeSameWineTwoVintages, 21, 211),
      _barcode(6, Fixture.codeSameWineTwoVintages, 21, 212),
      _barcode(7, Fixture.codeTwoBottleSizes, 30, 301, sizeMl: 750),
      _barcode(8, Fixture.codeTwoBottleSizes, 30, 301, sizeMl: 1500),
      _barcode(9, Fixture.codeUpcA, 20, 201),
      _barcode(10, Fixture.codeWineWithoutVintages, 40, null),
    ]);
    b.insertAll(db.wineTranslationTable, [
      WineTranslationTableCompanion.insert(
        wineId: 10,
        lang: 'ro',
        description: const Value('Vin roșu sec.'),
      ),
    ]);
    b.insertAll(db.vintageTranslationTable, [
      VintageTranslationTableCompanion.insert(
        vintageId: 102,
        lang: 'ro',
        sensoryNotes: const Value('Vișine, prune uscate.'),
        foodPairings: const Value(['Miel', 'Brânză maturată']),
      ),
      VintageTranslationTableCompanion.insert(
        vintageId: 102,
        lang: 'en',
        sensoryNotes: const Value('Sour cherry, dried plum.'),
        foodPairings: const Value(['Lamb', 'Aged cheese']),
      ),
    ]);
  });
  return db;
}

WineTableCompanion _wine(
  int id,
  int wineryId,
  String name,
  WineType type,
  List<String> grapes,
) => WineTableCompanion.insert(
  id: Value(id),
  wineryId: wineryId,
  name: name,
  type: type,
  grapeVarieties: Value(grapes),
);

VintageTableCompanion _vintage(int id, int wineId, int year) =>
    VintageTableCompanion.insert(id: Value(id), wineId: wineId, year: year);

BarcodeTableCompanion _barcode(
  int id,
  String code,
  int wineId,
  int? vintageId, {
  int? sizeMl,
}) => BarcodeTableCompanion.insert(
  id: Value(id),
  code: code,
  wineId: wineId,
  vintageId: Value(vintageId),
  bottleSizeMl: Value(sizeMl),
);
