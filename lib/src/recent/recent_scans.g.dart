// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_scans.dart';

// ignore_for_file: type=lint
class $RecentScanTableTable extends RecentScanTable
    with TableInfo<$RecentScanTableTable, RecentScanRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecentScanTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _vintageIdMeta = const VerificationMeta(
    'vintageId',
  );
  @override
  late final GeneratedColumn<int> vintageId = GeneratedColumn<int>(
    'vintage_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _viewedAtMeta = const VerificationMeta(
    'viewedAt',
  );
  @override
  late final GeneratedColumn<DateTime> viewedAt = GeneratedColumn<DateTime>(
    'viewed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [vintageId, viewedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recent_scan';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecentScanRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('vintage_id')) {
      context.handle(
        _vintageIdMeta,
        vintageId.isAcceptableOrUnknown(data['vintage_id']!, _vintageIdMeta),
      );
    }
    if (data.containsKey('viewed_at')) {
      context.handle(
        _viewedAtMeta,
        viewedAt.isAcceptableOrUnknown(data['viewed_at']!, _viewedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_viewedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {vintageId};
  @override
  RecentScanRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecentScanRow(
      vintageId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vintage_id'],
      )!,
      viewedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}viewed_at'],
      )!,
    );
  }

  @override
  $RecentScanTableTable createAlias(String alias) {
    return $RecentScanTableTable(attachedDatabase, alias);
  }
}

class RecentScanRow extends DataClass implements Insertable<RecentScanRow> {
  /// Catalogue vintage ID (stable across data versions).
  final int vintageId;
  final DateTime viewedAt;
  const RecentScanRow({required this.vintageId, required this.viewedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['vintage_id'] = Variable<int>(vintageId);
    map['viewed_at'] = Variable<DateTime>(viewedAt);
    return map;
  }

  RecentScanTableCompanion toCompanion(bool nullToAbsent) {
    return RecentScanTableCompanion(
      vintageId: Value(vintageId),
      viewedAt: Value(viewedAt),
    );
  }

  factory RecentScanRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecentScanRow(
      vintageId: serializer.fromJson<int>(json['vintageId']),
      viewedAt: serializer.fromJson<DateTime>(json['viewedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'vintageId': serializer.toJson<int>(vintageId),
      'viewedAt': serializer.toJson<DateTime>(viewedAt),
    };
  }

  RecentScanRow copyWith({int? vintageId, DateTime? viewedAt}) => RecentScanRow(
    vintageId: vintageId ?? this.vintageId,
    viewedAt: viewedAt ?? this.viewedAt,
  );
  RecentScanRow copyWithCompanion(RecentScanTableCompanion data) {
    return RecentScanRow(
      vintageId: data.vintageId.present ? data.vintageId.value : this.vintageId,
      viewedAt: data.viewedAt.present ? data.viewedAt.value : this.viewedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecentScanRow(')
          ..write('vintageId: $vintageId, ')
          ..write('viewedAt: $viewedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(vintageId, viewedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecentScanRow &&
          other.vintageId == this.vintageId &&
          other.viewedAt == this.viewedAt);
}

class RecentScanTableCompanion extends UpdateCompanion<RecentScanRow> {
  final Value<int> vintageId;
  final Value<DateTime> viewedAt;
  const RecentScanTableCompanion({
    this.vintageId = const Value.absent(),
    this.viewedAt = const Value.absent(),
  });
  RecentScanTableCompanion.insert({
    this.vintageId = const Value.absent(),
    required DateTime viewedAt,
  }) : viewedAt = Value(viewedAt);
  static Insertable<RecentScanRow> custom({
    Expression<int>? vintageId,
    Expression<DateTime>? viewedAt,
  }) {
    return RawValuesInsertable({
      if (vintageId != null) 'vintage_id': vintageId,
      if (viewedAt != null) 'viewed_at': viewedAt,
    });
  }

  RecentScanTableCompanion copyWith({
    Value<int>? vintageId,
    Value<DateTime>? viewedAt,
  }) {
    return RecentScanTableCompanion(
      vintageId: vintageId ?? this.vintageId,
      viewedAt: viewedAt ?? this.viewedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (vintageId.present) {
      map['vintage_id'] = Variable<int>(vintageId.value);
    }
    if (viewedAt.present) {
      map['viewed_at'] = Variable<DateTime>(viewedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecentScanTableCompanion(')
          ..write('vintageId: $vintageId, ')
          ..write('viewedAt: $viewedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$UserDatabase extends GeneratedDatabase {
  _$UserDatabase(QueryExecutor e) : super(e);
  $UserDatabaseManager get managers => $UserDatabaseManager(this);
  late final $RecentScanTableTable recentScanTable = $RecentScanTableTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [recentScanTable];
}

typedef $$RecentScanTableTableCreateCompanionBuilder =
    RecentScanTableCompanion Function({
      Value<int> vintageId,
      required DateTime viewedAt,
    });
typedef $$RecentScanTableTableUpdateCompanionBuilder =
    RecentScanTableCompanion Function({
      Value<int> vintageId,
      Value<DateTime> viewedAt,
    });

class $$RecentScanTableTableFilterComposer
    extends Composer<_$UserDatabase, $RecentScanTableTable> {
  $$RecentScanTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get vintageId => $composableBuilder(
    column: $table.vintageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get viewedAt => $composableBuilder(
    column: $table.viewedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RecentScanTableTableOrderingComposer
    extends Composer<_$UserDatabase, $RecentScanTableTable> {
  $$RecentScanTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get vintageId => $composableBuilder(
    column: $table.vintageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get viewedAt => $composableBuilder(
    column: $table.viewedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecentScanTableTableAnnotationComposer
    extends Composer<_$UserDatabase, $RecentScanTableTable> {
  $$RecentScanTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get vintageId =>
      $composableBuilder(column: $table.vintageId, builder: (column) => column);

  GeneratedColumn<DateTime> get viewedAt =>
      $composableBuilder(column: $table.viewedAt, builder: (column) => column);
}

class $$RecentScanTableTableTableManager
    extends
        RootTableManager<
          _$UserDatabase,
          $RecentScanTableTable,
          RecentScanRow,
          $$RecentScanTableTableFilterComposer,
          $$RecentScanTableTableOrderingComposer,
          $$RecentScanTableTableAnnotationComposer,
          $$RecentScanTableTableCreateCompanionBuilder,
          $$RecentScanTableTableUpdateCompanionBuilder,
          (
            RecentScanRow,
            BaseReferences<
              _$UserDatabase,
              $RecentScanTableTable,
              RecentScanRow
            >,
          ),
          RecentScanRow,
          PrefetchHooks Function()
        > {
  $$RecentScanTableTableTableManager(
    _$UserDatabase db,
    $RecentScanTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecentScanTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecentScanTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecentScanTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> vintageId = const Value.absent(),
                Value<DateTime> viewedAt = const Value.absent(),
              }) => RecentScanTableCompanion(
                vintageId: vintageId,
                viewedAt: viewedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> vintageId = const Value.absent(),
                required DateTime viewedAt,
              }) => RecentScanTableCompanion.insert(
                vintageId: vintageId,
                viewedAt: viewedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RecentScanTableTable, RecentScanRow>(table),
                  BaseReferences<
                    _$UserDatabase,
                    $RecentScanTableTable,
                    RecentScanRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RecentScanTableTableProcessedTableManager =
    ProcessedTableManager<
      _$UserDatabase,
      $RecentScanTableTable,
      RecentScanRow,
      $$RecentScanTableTableFilterComposer,
      $$RecentScanTableTableOrderingComposer,
      $$RecentScanTableTableAnnotationComposer,
      $$RecentScanTableTableCreateCompanionBuilder,
      $$RecentScanTableTableUpdateCompanionBuilder,
      (
        RecentScanRow,
        BaseReferences<_$UserDatabase, $RecentScanTableTable, RecentScanRow>,
      ),
      RecentScanRow,
      PrefetchHooks Function()
    >;

class $UserDatabaseManager {
  final _$UserDatabase _db;
  $UserDatabaseManager(this._db);
  $$RecentScanTableTableTableManager get recentScanTable =>
      $$RecentScanTableTableTableManager(_db, _db.recentScanTable);
}
