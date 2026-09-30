import 'package:drift/drift.dart';

part 'recent_scans.g.dart';

/// On-device user data, kept separate from the catalogue so a catalogue
/// swap never touches it. Nothing here leaves the device.
@DriftDatabase(tables: [RecentScanTable])
class UserDatabase extends _$UserDatabase {
  UserDatabase(super.e);

  @override
  int get schemaVersion => 1;
}

@DataClassName('RecentScanRow')
class RecentScanTable extends Table {
  @override
  String get tableName => 'recent_scan';

  /// Catalogue vintage ID (stable across data versions).
  IntColumn get vintageId => integer()();
  DateTimeColumn get viewedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {vintageId};
}

final class RecentScan {
  const RecentScan({required this.vintageId, required this.viewedAt});

  final int vintageId;
  final DateTime viewedAt;
}

/// Most recently viewed results, newest first, one entry per vintage.
class RecentScansStore {
  RecentScansStore(this._db, {this.limit = 50, DateTime Function()? clock})
    : _clock = clock ?? DateTime.now;

  final UserDatabase _db;
  final int limit;
  final DateTime Function() _clock;

  /// Call when the result screen for [vintageId] is shown. Viewing the
  /// same vintage again moves it to the top.
  Future<void> record(int vintageId) => _db.transaction(() async {
    await _db
        .into(_db.recentScanTable)
        .insertOnConflictUpdate(
          RecentScanTableCompanion.insert(
            vintageId: Value(vintageId),
            viewedAt: _clock(),
          ),
        );
    final keep = _db.selectOnly(_db.recentScanTable)
      ..addColumns([_db.recentScanTable.vintageId])
      ..orderBy([OrderingTerm.desc(_db.recentScanTable.viewedAt)])
      ..limit(limit);
    await (_db.delete(
      _db.recentScanTable,
    )..where((t) => t.vintageId.isNotInQuery(keep))).go();
  });

  Future<List<RecentScan>> list() async {
    final rows = await (_db.select(
      _db.recentScanTable,
    )..orderBy([(t) => OrderingTerm.desc(t.viewedAt)])).get();
    return [
      for (final row in rows)
        RecentScan(vintageId: row.vintageId, viewedAt: row.viewedAt),
    ];
  }

  Future<void> clear() => _db.delete(_db.recentScanTable).go();
}
