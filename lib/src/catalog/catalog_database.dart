import 'dart:convert';

import 'package:drift/drift.dart';

import 'models.dart';

part 'catalog_database.g.dart';

/// The bundled, read-only wine catalogue (see docs/data-model.md).
///
/// IDs are assigned in the source spreadsheet, never auto-incremented, and
/// must stay stable across data versions: recent scans on the device refer
/// to them.
@DriftDatabase(
  tables: [
    WineryTable,
    WineTable,
    VintageTable,
    BarcodeTable,
    WineTranslationTable,
    VintageTranslationTable,
    MetaTable,
  ],
)
class CatalogDatabase extends _$CatalogDatabase {
  CatalogDatabase(super.e);

  /// Must match `meta.schema_version` of any snapshot this app opens.
  static const int currentSchemaVersion = 1;

  @override
  int get schemaVersion => currentSchemaVersion;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (_) => customStatement('PRAGMA foreign_keys = ON'),
  );
}

@DataClassName('WineryRow')
class WineryTable extends Table {
  @override
  String get tableName => 'winery';

  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get region => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('WineRow')
class WineTable extends Table {
  @override
  String get tableName => 'wine';

  IntColumn get id => integer()();
  IntColumn get wineryId => integer().references(WineryTable, #id)();
  TextColumn get name => text()();
  TextColumn get type => textEnum<WineType>()();
  TextColumn get grapeVarieties => text()
      .map(const StringListConverter())
      .withDefault(const Constant('[]'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('VintageRow')
class VintageTable extends Table {
  @override
  String get tableName => 'vintage';

  IntColumn get id => integer()();
  IntColumn get wineId => integer().references(WineTable, #id)();
  IntColumn get year => integer()();
  RealColumn get abv => real().nullable()();
  RealColumn get acidityGL => real().named('acidity_g_l').nullable()();
  RealColumn get tanninsGL => real().named('tannins_g_l').nullable()();
  RealColumn get residualSugarGL =>
      real().named('residual_sugar_g_l').nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
    {wineId, year},
  ];
}

/// `code` is indexed but deliberately NOT unique: two wines sharing a code
/// is a real-world case the app must represent (collision).
@DataClassName('BarcodeRow')
@TableIndex(name: 'barcode_code_idx', columns: {#code})
class BarcodeTable extends Table {
  @override
  String get tableName => 'barcode';

  IntColumn get id => integer()();
  TextColumn get code => text()();
  IntColumn get wineId => integer().references(WineTable, #id)();

  /// Null when the code identifies the product rather than a harvest year.
  IntColumn get vintageId =>
      integer().nullable().references(VintageTable, #id)();
  IntColumn get bottleSizeMl => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('WineTranslationRow')
class WineTranslationTable extends Table {
  @override
  String get tableName => 'wine_translation';

  IntColumn get wineId => integer().references(WineTable, #id)();

  /// ISO 639-1 code: 'ro', 'en', 'ru'.
  TextColumn get lang => text()();
  TextColumn get description => text().nullable()();

  @override
  Set<Column> get primaryKey => {wineId, lang};
}

/// Sensory notes and pairings live per vintage: they change by harvest.
@DataClassName('VintageTranslationRow')
class VintageTranslationTable extends Table {
  @override
  String get tableName => 'vintage_translation';

  IntColumn get vintageId => integer().references(VintageTable, #id)();
  TextColumn get lang => text()();
  TextColumn get sensoryNotes => text().nullable()();
  TextColumn get foodPairings => text()
      .map(const StringListConverter())
      .withDefault(const Constant('[]'))();

  @override
  Set<Column> get primaryKey => {vintageId, lang};
}

/// Single row describing the snapshot.
@DataClassName('MetaRow')
class MetaTable extends Table {
  @override
  String get tableName => 'meta';

  IntColumn get dataVersion => integer()();
  IntColumn get schemaVersion => integer()();

  /// ISO-8601 UTC timestamp written by the build script.
  TextColumn get builtAt => text()();
}

/// Stores a list of strings as a JSON array in a TEXT column.
class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromSql(String fromDb) =>
      (jsonDecode(fromDb) as List<dynamic>).cast<String>();

  @override
  String toSql(List<String> value) => jsonEncode(value);
}
