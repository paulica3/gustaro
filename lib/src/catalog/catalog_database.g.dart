// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_database.dart';

// ignore_for_file: type=lint
class $WineryTableTable extends WineryTable
    with TableInfo<$WineryTableTable, WineryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WineryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
    'region',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, region];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'winery';
  @override
  VerificationContext validateIntegrity(
    Insertable<WineryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('region')) {
      context.handle(
        _regionMeta,
        region.isAcceptableOrUnknown(data['region']!, _regionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WineryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WineryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      region: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region'],
      ),
    );
  }

  @override
  $WineryTableTable createAlias(String alias) {
    return $WineryTableTable(attachedDatabase, alias);
  }
}

class WineryRow extends DataClass implements Insertable<WineryRow> {
  final int id;
  final String name;
  final String? region;
  const WineryRow({required this.id, required this.name, this.region});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || region != null) {
      map['region'] = Variable<String>(region);
    }
    return map;
  }

  WineryTableCompanion toCompanion(bool nullToAbsent) {
    return WineryTableCompanion(
      id: Value(id),
      name: Value(name),
      region: region == null && nullToAbsent
          ? const Value.absent()
          : Value(region),
    );
  }

  factory WineryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WineryRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      region: serializer.fromJson<String?>(json['region']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'region': serializer.toJson<String?>(region),
    };
  }

  WineryRow copyWith({
    int? id,
    String? name,
    Value<String?> region = const Value.absent(),
  }) => WineryRow(
    id: id ?? this.id,
    name: name ?? this.name,
    region: region.present ? region.value : this.region,
  );
  WineryRow copyWithCompanion(WineryTableCompanion data) {
    return WineryRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      region: data.region.present ? data.region.value : this.region,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WineryRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('region: $region')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, region);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WineryRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.region == this.region);
}

class WineryTableCompanion extends UpdateCompanion<WineryRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> region;
  const WineryTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.region = const Value.absent(),
  });
  WineryTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.region = const Value.absent(),
  }) : name = Value(name);
  static Insertable<WineryRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? region,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (region != null) 'region': region,
    });
  }

  WineryTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? region,
  }) {
    return WineryTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      region: region ?? this.region,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WineryTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('region: $region')
          ..write(')'))
        .toString();
  }
}

class $WineTableTable extends WineTable
    with TableInfo<$WineTableTable, WineRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WineTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wineryIdMeta = const VerificationMeta(
    'wineryId',
  );
  @override
  late final GeneratedColumn<int> wineryId = GeneratedColumn<int>(
    'winery_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES winery (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<WineType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<WineType>($WineTableTable.$convertertype);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
  grapeVarieties = GeneratedColumn<String>(
    'grape_varieties',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  ).withConverter<List<String>>($WineTableTable.$convertergrapeVarieties);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    wineryId,
    name,
    type,
    grapeVarieties,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wine';
  @override
  VerificationContext validateIntegrity(
    Insertable<WineRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('winery_id')) {
      context.handle(
        _wineryIdMeta,
        wineryId.isAcceptableOrUnknown(data['winery_id']!, _wineryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_wineryIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WineRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WineRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      wineryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}winery_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: $WineTableTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      grapeVarieties: $WineTableTable.$convertergrapeVarieties.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}grape_varieties'],
        )!,
      ),
    );
  }

  @override
  $WineTableTable createAlias(String alias) {
    return $WineTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<WineType, String, String> $convertertype =
      const EnumNameConverter<WineType>(WineType.values);
  static TypeConverter<List<String>, String> $convertergrapeVarieties =
      const StringListConverter();
}

class WineRow extends DataClass implements Insertable<WineRow> {
  final int id;
  final int wineryId;
  final String name;
  final WineType type;
  final List<String> grapeVarieties;
  const WineRow({
    required this.id,
    required this.wineryId,
    required this.name,
    required this.type,
    required this.grapeVarieties,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['winery_id'] = Variable<int>(wineryId);
    map['name'] = Variable<String>(name);
    {
      map['type'] = Variable<String>(
        $WineTableTable.$convertertype.toSql(type),
      );
    }
    {
      map['grape_varieties'] = Variable<String>(
        $WineTableTable.$convertergrapeVarieties.toSql(grapeVarieties),
      );
    }
    return map;
  }

  WineTableCompanion toCompanion(bool nullToAbsent) {
    return WineTableCompanion(
      id: Value(id),
      wineryId: Value(wineryId),
      name: Value(name),
      type: Value(type),
      grapeVarieties: Value(grapeVarieties),
    );
  }

  factory WineRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WineRow(
      id: serializer.fromJson<int>(json['id']),
      wineryId: serializer.fromJson<int>(json['wineryId']),
      name: serializer.fromJson<String>(json['name']),
      type: $WineTableTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      grapeVarieties: serializer.fromJson<List<String>>(json['grapeVarieties']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wineryId': serializer.toJson<int>(wineryId),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(
        $WineTableTable.$convertertype.toJson(type),
      ),
      'grapeVarieties': serializer.toJson<List<String>>(grapeVarieties),
    };
  }

  WineRow copyWith({
    int? id,
    int? wineryId,
    String? name,
    WineType? type,
    List<String>? grapeVarieties,
  }) => WineRow(
    id: id ?? this.id,
    wineryId: wineryId ?? this.wineryId,
    name: name ?? this.name,
    type: type ?? this.type,
    grapeVarieties: grapeVarieties ?? this.grapeVarieties,
  );
  WineRow copyWithCompanion(WineTableCompanion data) {
    return WineRow(
      id: data.id.present ? data.id.value : this.id,
      wineryId: data.wineryId.present ? data.wineryId.value : this.wineryId,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      grapeVarieties: data.grapeVarieties.present
          ? data.grapeVarieties.value
          : this.grapeVarieties,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WineRow(')
          ..write('id: $id, ')
          ..write('wineryId: $wineryId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('grapeVarieties: $grapeVarieties')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, wineryId, name, type, grapeVarieties);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WineRow &&
          other.id == this.id &&
          other.wineryId == this.wineryId &&
          other.name == this.name &&
          other.type == this.type &&
          other.grapeVarieties == this.grapeVarieties);
}

class WineTableCompanion extends UpdateCompanion<WineRow> {
  final Value<int> id;
  final Value<int> wineryId;
  final Value<String> name;
  final Value<WineType> type;
  final Value<List<String>> grapeVarieties;
  const WineTableCompanion({
    this.id = const Value.absent(),
    this.wineryId = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.grapeVarieties = const Value.absent(),
  });
  WineTableCompanion.insert({
    this.id = const Value.absent(),
    required int wineryId,
    required String name,
    required WineType type,
    this.grapeVarieties = const Value.absent(),
  }) : wineryId = Value(wineryId),
       name = Value(name),
       type = Value(type);
  static Insertable<WineRow> custom({
    Expression<int>? id,
    Expression<int>? wineryId,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? grapeVarieties,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wineryId != null) 'winery_id': wineryId,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (grapeVarieties != null) 'grape_varieties': grapeVarieties,
    });
  }

  WineTableCompanion copyWith({
    Value<int>? id,
    Value<int>? wineryId,
    Value<String>? name,
    Value<WineType>? type,
    Value<List<String>>? grapeVarieties,
  }) {
    return WineTableCompanion(
      id: id ?? this.id,
      wineryId: wineryId ?? this.wineryId,
      name: name ?? this.name,
      type: type ?? this.type,
      grapeVarieties: grapeVarieties ?? this.grapeVarieties,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wineryId.present) {
      map['winery_id'] = Variable<int>(wineryId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $WineTableTable.$convertertype.toSql(type.value),
      );
    }
    if (grapeVarieties.present) {
      map['grape_varieties'] = Variable<String>(
        $WineTableTable.$convertergrapeVarieties.toSql(grapeVarieties.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WineTableCompanion(')
          ..write('id: $id, ')
          ..write('wineryId: $wineryId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('grapeVarieties: $grapeVarieties')
          ..write(')'))
        .toString();
  }
}

class $VintageTableTable extends VintageTable
    with TableInfo<$VintageTableTable, VintageRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VintageTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wineIdMeta = const VerificationMeta('wineId');
  @override
  late final GeneratedColumn<int> wineId = GeneratedColumn<int>(
    'wine_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES wine (id)',
    ),
  );
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _abvMeta = const VerificationMeta('abv');
  @override
  late final GeneratedColumn<double> abv = GeneratedColumn<double>(
    'abv',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _acidityGLMeta = const VerificationMeta(
    'acidityGL',
  );
  @override
  late final GeneratedColumn<double> acidityGL = GeneratedColumn<double>(
    'acidity_g_l',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tanninsGLMeta = const VerificationMeta(
    'tanninsGL',
  );
  @override
  late final GeneratedColumn<double> tanninsGL = GeneratedColumn<double>(
    'tannins_g_l',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _residualSugarGLMeta = const VerificationMeta(
    'residualSugarGL',
  );
  @override
  late final GeneratedColumn<double> residualSugarGL = GeneratedColumn<double>(
    'residual_sugar_g_l',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    wineId,
    year,
    abv,
    acidityGL,
    tanninsGL,
    residualSugarGL,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vintage';
  @override
  VerificationContext validateIntegrity(
    Insertable<VintageRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('wine_id')) {
      context.handle(
        _wineIdMeta,
        wineId.isAcceptableOrUnknown(data['wine_id']!, _wineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_wineIdMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('abv')) {
      context.handle(
        _abvMeta,
        abv.isAcceptableOrUnknown(data['abv']!, _abvMeta),
      );
    }
    if (data.containsKey('acidity_g_l')) {
      context.handle(
        _acidityGLMeta,
        acidityGL.isAcceptableOrUnknown(data['acidity_g_l']!, _acidityGLMeta),
      );
    }
    if (data.containsKey('tannins_g_l')) {
      context.handle(
        _tanninsGLMeta,
        tanninsGL.isAcceptableOrUnknown(data['tannins_g_l']!, _tanninsGLMeta),
      );
    }
    if (data.containsKey('residual_sugar_g_l')) {
      context.handle(
        _residualSugarGLMeta,
        residualSugarGL.isAcceptableOrUnknown(
          data['residual_sugar_g_l']!,
          _residualSugarGLMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {wineId, year},
  ];
  @override
  VintageRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VintageRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      wineId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wine_id'],
      )!,
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      )!,
      abv: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}abv'],
      ),
      acidityGL: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}acidity_g_l'],
      ),
      tanninsGL: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tannins_g_l'],
      ),
      residualSugarGL: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}residual_sugar_g_l'],
      ),
    );
  }

  @override
  $VintageTableTable createAlias(String alias) {
    return $VintageTableTable(attachedDatabase, alias);
  }
}

class VintageRow extends DataClass implements Insertable<VintageRow> {
  final int id;
  final int wineId;
  final int year;
  final double? abv;
  final double? acidityGL;
  final double? tanninsGL;
  final double? residualSugarGL;
  const VintageRow({
    required this.id,
    required this.wineId,
    required this.year,
    this.abv,
    this.acidityGL,
    this.tanninsGL,
    this.residualSugarGL,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['wine_id'] = Variable<int>(wineId);
    map['year'] = Variable<int>(year);
    if (!nullToAbsent || abv != null) {
      map['abv'] = Variable<double>(abv);
    }
    if (!nullToAbsent || acidityGL != null) {
      map['acidity_g_l'] = Variable<double>(acidityGL);
    }
    if (!nullToAbsent || tanninsGL != null) {
      map['tannins_g_l'] = Variable<double>(tanninsGL);
    }
    if (!nullToAbsent || residualSugarGL != null) {
      map['residual_sugar_g_l'] = Variable<double>(residualSugarGL);
    }
    return map;
  }

  VintageTableCompanion toCompanion(bool nullToAbsent) {
    return VintageTableCompanion(
      id: Value(id),
      wineId: Value(wineId),
      year: Value(year),
      abv: abv == null && nullToAbsent ? const Value.absent() : Value(abv),
      acidityGL: acidityGL == null && nullToAbsent
          ? const Value.absent()
          : Value(acidityGL),
      tanninsGL: tanninsGL == null && nullToAbsent
          ? const Value.absent()
          : Value(tanninsGL),
      residualSugarGL: residualSugarGL == null && nullToAbsent
          ? const Value.absent()
          : Value(residualSugarGL),
    );
  }

  factory VintageRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VintageRow(
      id: serializer.fromJson<int>(json['id']),
      wineId: serializer.fromJson<int>(json['wineId']),
      year: serializer.fromJson<int>(json['year']),
      abv: serializer.fromJson<double?>(json['abv']),
      acidityGL: serializer.fromJson<double?>(json['acidityGL']),
      tanninsGL: serializer.fromJson<double?>(json['tanninsGL']),
      residualSugarGL: serializer.fromJson<double?>(json['residualSugarGL']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wineId': serializer.toJson<int>(wineId),
      'year': serializer.toJson<int>(year),
      'abv': serializer.toJson<double?>(abv),
      'acidityGL': serializer.toJson<double?>(acidityGL),
      'tanninsGL': serializer.toJson<double?>(tanninsGL),
      'residualSugarGL': serializer.toJson<double?>(residualSugarGL),
    };
  }

  VintageRow copyWith({
    int? id,
    int? wineId,
    int? year,
    Value<double?> abv = const Value.absent(),
    Value<double?> acidityGL = const Value.absent(),
    Value<double?> tanninsGL = const Value.absent(),
    Value<double?> residualSugarGL = const Value.absent(),
  }) => VintageRow(
    id: id ?? this.id,
    wineId: wineId ?? this.wineId,
    year: year ?? this.year,
    abv: abv.present ? abv.value : this.abv,
    acidityGL: acidityGL.present ? acidityGL.value : this.acidityGL,
    tanninsGL: tanninsGL.present ? tanninsGL.value : this.tanninsGL,
    residualSugarGL: residualSugarGL.present
        ? residualSugarGL.value
        : this.residualSugarGL,
  );
  VintageRow copyWithCompanion(VintageTableCompanion data) {
    return VintageRow(
      id: data.id.present ? data.id.value : this.id,
      wineId: data.wineId.present ? data.wineId.value : this.wineId,
      year: data.year.present ? data.year.value : this.year,
      abv: data.abv.present ? data.abv.value : this.abv,
      acidityGL: data.acidityGL.present ? data.acidityGL.value : this.acidityGL,
      tanninsGL: data.tanninsGL.present ? data.tanninsGL.value : this.tanninsGL,
      residualSugarGL: data.residualSugarGL.present
          ? data.residualSugarGL.value
          : this.residualSugarGL,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VintageRow(')
          ..write('id: $id, ')
          ..write('wineId: $wineId, ')
          ..write('year: $year, ')
          ..write('abv: $abv, ')
          ..write('acidityGL: $acidityGL, ')
          ..write('tanninsGL: $tanninsGL, ')
          ..write('residualSugarGL: $residualSugarGL')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, wineId, year, abv, acidityGL, tanninsGL, residualSugarGL);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VintageRow &&
          other.id == this.id &&
          other.wineId == this.wineId &&
          other.year == this.year &&
          other.abv == this.abv &&
          other.acidityGL == this.acidityGL &&
          other.tanninsGL == this.tanninsGL &&
          other.residualSugarGL == this.residualSugarGL);
}

class VintageTableCompanion extends UpdateCompanion<VintageRow> {
  final Value<int> id;
  final Value<int> wineId;
  final Value<int> year;
  final Value<double?> abv;
  final Value<double?> acidityGL;
  final Value<double?> tanninsGL;
  final Value<double?> residualSugarGL;
  const VintageTableCompanion({
    this.id = const Value.absent(),
    this.wineId = const Value.absent(),
    this.year = const Value.absent(),
    this.abv = const Value.absent(),
    this.acidityGL = const Value.absent(),
    this.tanninsGL = const Value.absent(),
    this.residualSugarGL = const Value.absent(),
  });
  VintageTableCompanion.insert({
    this.id = const Value.absent(),
    required int wineId,
    required int year,
    this.abv = const Value.absent(),
    this.acidityGL = const Value.absent(),
    this.tanninsGL = const Value.absent(),
    this.residualSugarGL = const Value.absent(),
  }) : wineId = Value(wineId),
       year = Value(year);
  static Insertable<VintageRow> custom({
    Expression<int>? id,
    Expression<int>? wineId,
    Expression<int>? year,
    Expression<double>? abv,
    Expression<double>? acidityGL,
    Expression<double>? tanninsGL,
    Expression<double>? residualSugarGL,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wineId != null) 'wine_id': wineId,
      if (year != null) 'year': year,
      if (abv != null) 'abv': abv,
      if (acidityGL != null) 'acidity_g_l': acidityGL,
      if (tanninsGL != null) 'tannins_g_l': tanninsGL,
      if (residualSugarGL != null) 'residual_sugar_g_l': residualSugarGL,
    });
  }

  VintageTableCompanion copyWith({
    Value<int>? id,
    Value<int>? wineId,
    Value<int>? year,
    Value<double?>? abv,
    Value<double?>? acidityGL,
    Value<double?>? tanninsGL,
    Value<double?>? residualSugarGL,
  }) {
    return VintageTableCompanion(
      id: id ?? this.id,
      wineId: wineId ?? this.wineId,
      year: year ?? this.year,
      abv: abv ?? this.abv,
      acidityGL: acidityGL ?? this.acidityGL,
      tanninsGL: tanninsGL ?? this.tanninsGL,
      residualSugarGL: residualSugarGL ?? this.residualSugarGL,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wineId.present) {
      map['wine_id'] = Variable<int>(wineId.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (abv.present) {
      map['abv'] = Variable<double>(abv.value);
    }
    if (acidityGL.present) {
      map['acidity_g_l'] = Variable<double>(acidityGL.value);
    }
    if (tanninsGL.present) {
      map['tannins_g_l'] = Variable<double>(tanninsGL.value);
    }
    if (residualSugarGL.present) {
      map['residual_sugar_g_l'] = Variable<double>(residualSugarGL.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VintageTableCompanion(')
          ..write('id: $id, ')
          ..write('wineId: $wineId, ')
          ..write('year: $year, ')
          ..write('abv: $abv, ')
          ..write('acidityGL: $acidityGL, ')
          ..write('tanninsGL: $tanninsGL, ')
          ..write('residualSugarGL: $residualSugarGL')
          ..write(')'))
        .toString();
  }
}

class $BarcodeTableTable extends BarcodeTable
    with TableInfo<$BarcodeTableTable, BarcodeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BarcodeTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wineIdMeta = const VerificationMeta('wineId');
  @override
  late final GeneratedColumn<int> wineId = GeneratedColumn<int>(
    'wine_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES wine (id)',
    ),
  );
  static const VerificationMeta _vintageIdMeta = const VerificationMeta(
    'vintageId',
  );
  @override
  late final GeneratedColumn<int> vintageId = GeneratedColumn<int>(
    'vintage_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vintage (id)',
    ),
  );
  static const VerificationMeta _bottleSizeMlMeta = const VerificationMeta(
    'bottleSizeMl',
  );
  @override
  late final GeneratedColumn<int> bottleSizeMl = GeneratedColumn<int>(
    'bottle_size_ml',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    wineId,
    vintageId,
    bottleSizeMl,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'barcode';
  @override
  VerificationContext validateIntegrity(
    Insertable<BarcodeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('wine_id')) {
      context.handle(
        _wineIdMeta,
        wineId.isAcceptableOrUnknown(data['wine_id']!, _wineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_wineIdMeta);
    }
    if (data.containsKey('vintage_id')) {
      context.handle(
        _vintageIdMeta,
        vintageId.isAcceptableOrUnknown(data['vintage_id']!, _vintageIdMeta),
      );
    }
    if (data.containsKey('bottle_size_ml')) {
      context.handle(
        _bottleSizeMlMeta,
        bottleSizeMl.isAcceptableOrUnknown(
          data['bottle_size_ml']!,
          _bottleSizeMlMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BarcodeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BarcodeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      wineId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wine_id'],
      )!,
      vintageId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vintage_id'],
      ),
      bottleSizeMl: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bottle_size_ml'],
      ),
    );
  }

  @override
  $BarcodeTableTable createAlias(String alias) {
    return $BarcodeTableTable(attachedDatabase, alias);
  }
}

class BarcodeRow extends DataClass implements Insertable<BarcodeRow> {
  final int id;
  final String code;
  final int wineId;

  /// Null when the code identifies the product rather than a harvest year.
  final int? vintageId;
  final int? bottleSizeMl;
  const BarcodeRow({
    required this.id,
    required this.code,
    required this.wineId,
    this.vintageId,
    this.bottleSizeMl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['wine_id'] = Variable<int>(wineId);
    if (!nullToAbsent || vintageId != null) {
      map['vintage_id'] = Variable<int>(vintageId);
    }
    if (!nullToAbsent || bottleSizeMl != null) {
      map['bottle_size_ml'] = Variable<int>(bottleSizeMl);
    }
    return map;
  }

  BarcodeTableCompanion toCompanion(bool nullToAbsent) {
    return BarcodeTableCompanion(
      id: Value(id),
      code: Value(code),
      wineId: Value(wineId),
      vintageId: vintageId == null && nullToAbsent
          ? const Value.absent()
          : Value(vintageId),
      bottleSizeMl: bottleSizeMl == null && nullToAbsent
          ? const Value.absent()
          : Value(bottleSizeMl),
    );
  }

  factory BarcodeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BarcodeRow(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      wineId: serializer.fromJson<int>(json['wineId']),
      vintageId: serializer.fromJson<int?>(json['vintageId']),
      bottleSizeMl: serializer.fromJson<int?>(json['bottleSizeMl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'wineId': serializer.toJson<int>(wineId),
      'vintageId': serializer.toJson<int?>(vintageId),
      'bottleSizeMl': serializer.toJson<int?>(bottleSizeMl),
    };
  }

  BarcodeRow copyWith({
    int? id,
    String? code,
    int? wineId,
    Value<int?> vintageId = const Value.absent(),
    Value<int?> bottleSizeMl = const Value.absent(),
  }) => BarcodeRow(
    id: id ?? this.id,
    code: code ?? this.code,
    wineId: wineId ?? this.wineId,
    vintageId: vintageId.present ? vintageId.value : this.vintageId,
    bottleSizeMl: bottleSizeMl.present ? bottleSizeMl.value : this.bottleSizeMl,
  );
  BarcodeRow copyWithCompanion(BarcodeTableCompanion data) {
    return BarcodeRow(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      wineId: data.wineId.present ? data.wineId.value : this.wineId,
      vintageId: data.vintageId.present ? data.vintageId.value : this.vintageId,
      bottleSizeMl: data.bottleSizeMl.present
          ? data.bottleSizeMl.value
          : this.bottleSizeMl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BarcodeRow(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('wineId: $wineId, ')
          ..write('vintageId: $vintageId, ')
          ..write('bottleSizeMl: $bottleSizeMl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, code, wineId, vintageId, bottleSizeMl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BarcodeRow &&
          other.id == this.id &&
          other.code == this.code &&
          other.wineId == this.wineId &&
          other.vintageId == this.vintageId &&
          other.bottleSizeMl == this.bottleSizeMl);
}

class BarcodeTableCompanion extends UpdateCompanion<BarcodeRow> {
  final Value<int> id;
  final Value<String> code;
  final Value<int> wineId;
  final Value<int?> vintageId;
  final Value<int?> bottleSizeMl;
  const BarcodeTableCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.wineId = const Value.absent(),
    this.vintageId = const Value.absent(),
    this.bottleSizeMl = const Value.absent(),
  });
  BarcodeTableCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required int wineId,
    this.vintageId = const Value.absent(),
    this.bottleSizeMl = const Value.absent(),
  }) : code = Value(code),
       wineId = Value(wineId);
  static Insertable<BarcodeRow> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<int>? wineId,
    Expression<int>? vintageId,
    Expression<int>? bottleSizeMl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (wineId != null) 'wine_id': wineId,
      if (vintageId != null) 'vintage_id': vintageId,
      if (bottleSizeMl != null) 'bottle_size_ml': bottleSizeMl,
    });
  }

  BarcodeTableCompanion copyWith({
    Value<int>? id,
    Value<String>? code,
    Value<int>? wineId,
    Value<int?>? vintageId,
    Value<int?>? bottleSizeMl,
  }) {
    return BarcodeTableCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      wineId: wineId ?? this.wineId,
      vintageId: vintageId ?? this.vintageId,
      bottleSizeMl: bottleSizeMl ?? this.bottleSizeMl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (wineId.present) {
      map['wine_id'] = Variable<int>(wineId.value);
    }
    if (vintageId.present) {
      map['vintage_id'] = Variable<int>(vintageId.value);
    }
    if (bottleSizeMl.present) {
      map['bottle_size_ml'] = Variable<int>(bottleSizeMl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BarcodeTableCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('wineId: $wineId, ')
          ..write('vintageId: $vintageId, ')
          ..write('bottleSizeMl: $bottleSizeMl')
          ..write(')'))
        .toString();
  }
}

class $WineTranslationTableTable extends WineTranslationTable
    with TableInfo<$WineTranslationTableTable, WineTranslationRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WineTranslationTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _wineIdMeta = const VerificationMeta('wineId');
  @override
  late final GeneratedColumn<int> wineId = GeneratedColumn<int>(
    'wine_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES wine (id)',
    ),
  );
  static const VerificationMeta _langMeta = const VerificationMeta('lang');
  @override
  late final GeneratedColumn<String> lang = GeneratedColumn<String>(
    'lang',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [wineId, lang, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wine_translation';
  @override
  VerificationContext validateIntegrity(
    Insertable<WineTranslationRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('wine_id')) {
      context.handle(
        _wineIdMeta,
        wineId.isAcceptableOrUnknown(data['wine_id']!, _wineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_wineIdMeta);
    }
    if (data.containsKey('lang')) {
      context.handle(
        _langMeta,
        lang.isAcceptableOrUnknown(data['lang']!, _langMeta),
      );
    } else if (isInserting) {
      context.missing(_langMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {wineId, lang};
  @override
  WineTranslationRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WineTranslationRow(
      wineId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wine_id'],
      )!,
      lang: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lang'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
    );
  }

  @override
  $WineTranslationTableTable createAlias(String alias) {
    return $WineTranslationTableTable(attachedDatabase, alias);
  }
}

class WineTranslationRow extends DataClass
    implements Insertable<WineTranslationRow> {
  final int wineId;

  /// ISO 639-1 code: 'ro', 'en', 'ru'.
  final String lang;
  final String? description;
  const WineTranslationRow({
    required this.wineId,
    required this.lang,
    this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['wine_id'] = Variable<int>(wineId);
    map['lang'] = Variable<String>(lang);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  WineTranslationTableCompanion toCompanion(bool nullToAbsent) {
    return WineTranslationTableCompanion(
      wineId: Value(wineId),
      lang: Value(lang),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory WineTranslationRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WineTranslationRow(
      wineId: serializer.fromJson<int>(json['wineId']),
      lang: serializer.fromJson<String>(json['lang']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'wineId': serializer.toJson<int>(wineId),
      'lang': serializer.toJson<String>(lang),
      'description': serializer.toJson<String?>(description),
    };
  }

  WineTranslationRow copyWith({
    int? wineId,
    String? lang,
    Value<String?> description = const Value.absent(),
  }) => WineTranslationRow(
    wineId: wineId ?? this.wineId,
    lang: lang ?? this.lang,
    description: description.present ? description.value : this.description,
  );
  WineTranslationRow copyWithCompanion(WineTranslationTableCompanion data) {
    return WineTranslationRow(
      wineId: data.wineId.present ? data.wineId.value : this.wineId,
      lang: data.lang.present ? data.lang.value : this.lang,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WineTranslationRow(')
          ..write('wineId: $wineId, ')
          ..write('lang: $lang, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(wineId, lang, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WineTranslationRow &&
          other.wineId == this.wineId &&
          other.lang == this.lang &&
          other.description == this.description);
}

class WineTranslationTableCompanion
    extends UpdateCompanion<WineTranslationRow> {
  final Value<int> wineId;
  final Value<String> lang;
  final Value<String?> description;
  final Value<int> rowid;
  const WineTranslationTableCompanion({
    this.wineId = const Value.absent(),
    this.lang = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WineTranslationTableCompanion.insert({
    required int wineId,
    required String lang,
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : wineId = Value(wineId),
       lang = Value(lang);
  static Insertable<WineTranslationRow> custom({
    Expression<int>? wineId,
    Expression<String>? lang,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (wineId != null) 'wine_id': wineId,
      if (lang != null) 'lang': lang,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WineTranslationTableCompanion copyWith({
    Value<int>? wineId,
    Value<String>? lang,
    Value<String?>? description,
    Value<int>? rowid,
  }) {
    return WineTranslationTableCompanion(
      wineId: wineId ?? this.wineId,
      lang: lang ?? this.lang,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (wineId.present) {
      map['wine_id'] = Variable<int>(wineId.value);
    }
    if (lang.present) {
      map['lang'] = Variable<String>(lang.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WineTranslationTableCompanion(')
          ..write('wineId: $wineId, ')
          ..write('lang: $lang, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VintageTranslationTableTable extends VintageTranslationTable
    with TableInfo<$VintageTranslationTableTable, VintageTranslationRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VintageTranslationTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _vintageIdMeta = const VerificationMeta(
    'vintageId',
  );
  @override
  late final GeneratedColumn<int> vintageId = GeneratedColumn<int>(
    'vintage_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vintage (id)',
    ),
  );
  static const VerificationMeta _langMeta = const VerificationMeta('lang');
  @override
  late final GeneratedColumn<String> lang = GeneratedColumn<String>(
    'lang',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sensoryNotesMeta = const VerificationMeta(
    'sensoryNotes',
  );
  @override
  late final GeneratedColumn<String> sensoryNotes = GeneratedColumn<String>(
    'sensory_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
  foodPairings =
      GeneratedColumn<String>(
        'food_pairings',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      ).withConverter<List<String>>(
        $VintageTranslationTableTable.$converterfoodPairings,
      );
  @override
  List<GeneratedColumn> get $columns => [
    vintageId,
    lang,
    sensoryNotes,
    foodPairings,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vintage_translation';
  @override
  VerificationContext validateIntegrity(
    Insertable<VintageTranslationRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('vintage_id')) {
      context.handle(
        _vintageIdMeta,
        vintageId.isAcceptableOrUnknown(data['vintage_id']!, _vintageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vintageIdMeta);
    }
    if (data.containsKey('lang')) {
      context.handle(
        _langMeta,
        lang.isAcceptableOrUnknown(data['lang']!, _langMeta),
      );
    } else if (isInserting) {
      context.missing(_langMeta);
    }
    if (data.containsKey('sensory_notes')) {
      context.handle(
        _sensoryNotesMeta,
        sensoryNotes.isAcceptableOrUnknown(
          data['sensory_notes']!,
          _sensoryNotesMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {vintageId, lang};
  @override
  VintageTranslationRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VintageTranslationRow(
      vintageId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vintage_id'],
      )!,
      lang: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lang'],
      )!,
      sensoryNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sensory_notes'],
      ),
      foodPairings: $VintageTranslationTableTable.$converterfoodPairings
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}food_pairings'],
            )!,
          ),
    );
  }

  @override
  $VintageTranslationTableTable createAlias(String alias) {
    return $VintageTranslationTableTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converterfoodPairings =
      const StringListConverter();
}

class VintageTranslationRow extends DataClass
    implements Insertable<VintageTranslationRow> {
  final int vintageId;
  final String lang;
  final String? sensoryNotes;
  final List<String> foodPairings;
  const VintageTranslationRow({
    required this.vintageId,
    required this.lang,
    this.sensoryNotes,
    required this.foodPairings,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['vintage_id'] = Variable<int>(vintageId);
    map['lang'] = Variable<String>(lang);
    if (!nullToAbsent || sensoryNotes != null) {
      map['sensory_notes'] = Variable<String>(sensoryNotes);
    }
    {
      map['food_pairings'] = Variable<String>(
        $VintageTranslationTableTable.$converterfoodPairings.toSql(
          foodPairings,
        ),
      );
    }
    return map;
  }

  VintageTranslationTableCompanion toCompanion(bool nullToAbsent) {
    return VintageTranslationTableCompanion(
      vintageId: Value(vintageId),
      lang: Value(lang),
      sensoryNotes: sensoryNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(sensoryNotes),
      foodPairings: Value(foodPairings),
    );
  }

  factory VintageTranslationRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VintageTranslationRow(
      vintageId: serializer.fromJson<int>(json['vintageId']),
      lang: serializer.fromJson<String>(json['lang']),
      sensoryNotes: serializer.fromJson<String?>(json['sensoryNotes']),
      foodPairings: serializer.fromJson<List<String>>(json['foodPairings']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'vintageId': serializer.toJson<int>(vintageId),
      'lang': serializer.toJson<String>(lang),
      'sensoryNotes': serializer.toJson<String?>(sensoryNotes),
      'foodPairings': serializer.toJson<List<String>>(foodPairings),
    };
  }

  VintageTranslationRow copyWith({
    int? vintageId,
    String? lang,
    Value<String?> sensoryNotes = const Value.absent(),
    List<String>? foodPairings,
  }) => VintageTranslationRow(
    vintageId: vintageId ?? this.vintageId,
    lang: lang ?? this.lang,
    sensoryNotes: sensoryNotes.present ? sensoryNotes.value : this.sensoryNotes,
    foodPairings: foodPairings ?? this.foodPairings,
  );
  VintageTranslationRow copyWithCompanion(
    VintageTranslationTableCompanion data,
  ) {
    return VintageTranslationRow(
      vintageId: data.vintageId.present ? data.vintageId.value : this.vintageId,
      lang: data.lang.present ? data.lang.value : this.lang,
      sensoryNotes: data.sensoryNotes.present
          ? data.sensoryNotes.value
          : this.sensoryNotes,
      foodPairings: data.foodPairings.present
          ? data.foodPairings.value
          : this.foodPairings,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VintageTranslationRow(')
          ..write('vintageId: $vintageId, ')
          ..write('lang: $lang, ')
          ..write('sensoryNotes: $sensoryNotes, ')
          ..write('foodPairings: $foodPairings')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(vintageId, lang, sensoryNotes, foodPairings);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VintageTranslationRow &&
          other.vintageId == this.vintageId &&
          other.lang == this.lang &&
          other.sensoryNotes == this.sensoryNotes &&
          other.foodPairings == this.foodPairings);
}

class VintageTranslationTableCompanion
    extends UpdateCompanion<VintageTranslationRow> {
  final Value<int> vintageId;
  final Value<String> lang;
  final Value<String?> sensoryNotes;
  final Value<List<String>> foodPairings;
  final Value<int> rowid;
  const VintageTranslationTableCompanion({
    this.vintageId = const Value.absent(),
    this.lang = const Value.absent(),
    this.sensoryNotes = const Value.absent(),
    this.foodPairings = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VintageTranslationTableCompanion.insert({
    required int vintageId,
    required String lang,
    this.sensoryNotes = const Value.absent(),
    this.foodPairings = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : vintageId = Value(vintageId),
       lang = Value(lang);
  static Insertable<VintageTranslationRow> custom({
    Expression<int>? vintageId,
    Expression<String>? lang,
    Expression<String>? sensoryNotes,
    Expression<String>? foodPairings,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (vintageId != null) 'vintage_id': vintageId,
      if (lang != null) 'lang': lang,
      if (sensoryNotes != null) 'sensory_notes': sensoryNotes,
      if (foodPairings != null) 'food_pairings': foodPairings,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VintageTranslationTableCompanion copyWith({
    Value<int>? vintageId,
    Value<String>? lang,
    Value<String?>? sensoryNotes,
    Value<List<String>>? foodPairings,
    Value<int>? rowid,
  }) {
    return VintageTranslationTableCompanion(
      vintageId: vintageId ?? this.vintageId,
      lang: lang ?? this.lang,
      sensoryNotes: sensoryNotes ?? this.sensoryNotes,
      foodPairings: foodPairings ?? this.foodPairings,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (vintageId.present) {
      map['vintage_id'] = Variable<int>(vintageId.value);
    }
    if (lang.present) {
      map['lang'] = Variable<String>(lang.value);
    }
    if (sensoryNotes.present) {
      map['sensory_notes'] = Variable<String>(sensoryNotes.value);
    }
    if (foodPairings.present) {
      map['food_pairings'] = Variable<String>(
        $VintageTranslationTableTable.$converterfoodPairings.toSql(
          foodPairings.value,
        ),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VintageTranslationTableCompanion(')
          ..write('vintageId: $vintageId, ')
          ..write('lang: $lang, ')
          ..write('sensoryNotes: $sensoryNotes, ')
          ..write('foodPairings: $foodPairings, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MetaTableTable extends MetaTable
    with TableInfo<$MetaTableTable, MetaRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MetaTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dataVersionMeta = const VerificationMeta(
    'dataVersion',
  );
  @override
  late final GeneratedColumn<int> dataVersion = GeneratedColumn<int>(
    'data_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _schemaVersionMeta = const VerificationMeta(
    'schemaVersion',
  );
  @override
  late final GeneratedColumn<int> schemaVersion = GeneratedColumn<int>(
    'schema_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _builtAtMeta = const VerificationMeta(
    'builtAt',
  );
  @override
  late final GeneratedColumn<String> builtAt = GeneratedColumn<String>(
    'built_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [dataVersion, schemaVersion, builtAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meta';
  @override
  VerificationContext validateIntegrity(
    Insertable<MetaRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('data_version')) {
      context.handle(
        _dataVersionMeta,
        dataVersion.isAcceptableOrUnknown(
          data['data_version']!,
          _dataVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dataVersionMeta);
    }
    if (data.containsKey('schema_version')) {
      context.handle(
        _schemaVersionMeta,
        schemaVersion.isAcceptableOrUnknown(
          data['schema_version']!,
          _schemaVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_schemaVersionMeta);
    }
    if (data.containsKey('built_at')) {
      context.handle(
        _builtAtMeta,
        builtAt.isAcceptableOrUnknown(data['built_at']!, _builtAtMeta),
      );
    } else if (isInserting) {
      context.missing(_builtAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  MetaRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MetaRow(
      dataVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}data_version'],
      )!,
      schemaVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}schema_version'],
      )!,
      builtAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}built_at'],
      )!,
    );
  }

  @override
  $MetaTableTable createAlias(String alias) {
    return $MetaTableTable(attachedDatabase, alias);
  }
}

class MetaRow extends DataClass implements Insertable<MetaRow> {
  final int dataVersion;
  final int schemaVersion;

  /// ISO-8601 UTC timestamp written by the build script.
  final String builtAt;
  const MetaRow({
    required this.dataVersion,
    required this.schemaVersion,
    required this.builtAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['data_version'] = Variable<int>(dataVersion);
    map['schema_version'] = Variable<int>(schemaVersion);
    map['built_at'] = Variable<String>(builtAt);
    return map;
  }

  MetaTableCompanion toCompanion(bool nullToAbsent) {
    return MetaTableCompanion(
      dataVersion: Value(dataVersion),
      schemaVersion: Value(schemaVersion),
      builtAt: Value(builtAt),
    );
  }

  factory MetaRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MetaRow(
      dataVersion: serializer.fromJson<int>(json['dataVersion']),
      schemaVersion: serializer.fromJson<int>(json['schemaVersion']),
      builtAt: serializer.fromJson<String>(json['builtAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'dataVersion': serializer.toJson<int>(dataVersion),
      'schemaVersion': serializer.toJson<int>(schemaVersion),
      'builtAt': serializer.toJson<String>(builtAt),
    };
  }

  MetaRow copyWith({int? dataVersion, int? schemaVersion, String? builtAt}) =>
      MetaRow(
        dataVersion: dataVersion ?? this.dataVersion,
        schemaVersion: schemaVersion ?? this.schemaVersion,
        builtAt: builtAt ?? this.builtAt,
      );
  MetaRow copyWithCompanion(MetaTableCompanion data) {
    return MetaRow(
      dataVersion: data.dataVersion.present
          ? data.dataVersion.value
          : this.dataVersion,
      schemaVersion: data.schemaVersion.present
          ? data.schemaVersion.value
          : this.schemaVersion,
      builtAt: data.builtAt.present ? data.builtAt.value : this.builtAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MetaRow(')
          ..write('dataVersion: $dataVersion, ')
          ..write('schemaVersion: $schemaVersion, ')
          ..write('builtAt: $builtAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(dataVersion, schemaVersion, builtAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MetaRow &&
          other.dataVersion == this.dataVersion &&
          other.schemaVersion == this.schemaVersion &&
          other.builtAt == this.builtAt);
}

class MetaTableCompanion extends UpdateCompanion<MetaRow> {
  final Value<int> dataVersion;
  final Value<int> schemaVersion;
  final Value<String> builtAt;
  final Value<int> rowid;
  const MetaTableCompanion({
    this.dataVersion = const Value.absent(),
    this.schemaVersion = const Value.absent(),
    this.builtAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MetaTableCompanion.insert({
    required int dataVersion,
    required int schemaVersion,
    required String builtAt,
    this.rowid = const Value.absent(),
  }) : dataVersion = Value(dataVersion),
       schemaVersion = Value(schemaVersion),
       builtAt = Value(builtAt);
  static Insertable<MetaRow> custom({
    Expression<int>? dataVersion,
    Expression<int>? schemaVersion,
    Expression<String>? builtAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (dataVersion != null) 'data_version': dataVersion,
      if (schemaVersion != null) 'schema_version': schemaVersion,
      if (builtAt != null) 'built_at': builtAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MetaTableCompanion copyWith({
    Value<int>? dataVersion,
    Value<int>? schemaVersion,
    Value<String>? builtAt,
    Value<int>? rowid,
  }) {
    return MetaTableCompanion(
      dataVersion: dataVersion ?? this.dataVersion,
      schemaVersion: schemaVersion ?? this.schemaVersion,
      builtAt: builtAt ?? this.builtAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (dataVersion.present) {
      map['data_version'] = Variable<int>(dataVersion.value);
    }
    if (schemaVersion.present) {
      map['schema_version'] = Variable<int>(schemaVersion.value);
    }
    if (builtAt.present) {
      map['built_at'] = Variable<String>(builtAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MetaTableCompanion(')
          ..write('dataVersion: $dataVersion, ')
          ..write('schemaVersion: $schemaVersion, ')
          ..write('builtAt: $builtAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$CatalogDatabase extends GeneratedDatabase {
  _$CatalogDatabase(QueryExecutor e) : super(e);
  $CatalogDatabaseManager get managers => $CatalogDatabaseManager(this);
  late final $WineryTableTable wineryTable = $WineryTableTable(this);
  late final $WineTableTable wineTable = $WineTableTable(this);
  late final $VintageTableTable vintageTable = $VintageTableTable(this);
  late final $BarcodeTableTable barcodeTable = $BarcodeTableTable(this);
  late final $WineTranslationTableTable wineTranslationTable =
      $WineTranslationTableTable(this);
  late final $VintageTranslationTableTable vintageTranslationTable =
      $VintageTranslationTableTable(this);
  late final $MetaTableTable metaTable = $MetaTableTable(this);
  late final Index barcodeCodeIdx = Index(
    'barcode_code_idx',
    'CREATE INDEX barcode_code_idx ON barcode (code)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    wineryTable,
    wineTable,
    vintageTable,
    barcodeTable,
    wineTranslationTable,
    vintageTranslationTable,
    metaTable,
    barcodeCodeIdx,
  ];
}

typedef $$WineryTableTableCreateCompanionBuilder =
    WineryTableCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> region,
    });
typedef $$WineryTableTableUpdateCompanionBuilder =
    WineryTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> region,
    });

final class $$WineryTableTableReferences
    extends BaseReferences<_$CatalogDatabase, $WineryTableTable, WineryRow> {
  $$WineryTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WineTableTable, List<WineRow>>
  _wineTableRefsTable(_$CatalogDatabase db) => MultiTypedResultKey.fromTable(
    db.wineTable,
    aliasName: 'winery__id__wine__winery_id',
  );

  $$WineTableTableProcessedTableManager get wineTableRefs {
    final manager = $$WineTableTableTableManager(
      $_db,
      $_db.wineTable,
    ).filter((f) => f.wineryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_wineTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WineryTableTableFilterComposer
    extends Composer<_$CatalogDatabase, $WineryTableTable> {
  $$WineryTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> wineTableRefs(
    Expression<bool> Function($$WineTableTableFilterComposer f) f,
  ) {
    final $$WineTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wineTable,
      getReferencedColumn: (t) => t.wineryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WineTableTableFilterComposer(
            $db: $db,
            $table: $db.wineTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WineryTableTableOrderingComposer
    extends Composer<_$CatalogDatabase, $WineryTableTable> {
  $$WineryTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WineryTableTableAnnotationComposer
    extends Composer<_$CatalogDatabase, $WineryTableTable> {
  $$WineryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  Expression<T> wineTableRefs<T extends Object>(
    Expression<T> Function($$WineTableTableAnnotationComposer a) f,
  ) {
    final $$WineTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wineTable,
      getReferencedColumn: (t) => t.wineryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WineTableTableAnnotationComposer(
            $db: $db,
            $table: $db.wineTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WineryTableTableTableManager
    extends
        RootTableManager<
          _$CatalogDatabase,
          $WineryTableTable,
          WineryRow,
          $$WineryTableTableFilterComposer,
          $$WineryTableTableOrderingComposer,
          $$WineryTableTableAnnotationComposer,
          $$WineryTableTableCreateCompanionBuilder,
          $$WineryTableTableUpdateCompanionBuilder,
          (WineryRow, $$WineryTableTableReferences),
          WineryRow,
          PrefetchHooks Function({bool wineTableRefs})
        > {
  $$WineryTableTableTableManager(_$CatalogDatabase db, $WineryTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WineryTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WineryTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WineryTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> region = const Value.absent(),
          }) => WineryTableCompanion(id: id, name: name, region: region),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> region = const Value.absent(),
          }) => WineryTableCompanion.insert(id: id, name: name, region: region),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WineryTableTable, WineryRow>(table),
                  $$WineryTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({wineTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (wineTableRefs) db.wineTable],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (wineTableRefs)
                    await $_getPrefetchedData<
                      WineryRow,
                      $WineryTableTable,
                      WineRow
                    >(
                      currentTable: table,
                      referencedTable: $$WineryTableTableReferences
                          ._wineTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$WineryTableTableReferences(
                            db,
                            table,
                            p0,
                          ).wineTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.wineryId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$WineryTableTableProcessedTableManager =
    ProcessedTableManager<
      _$CatalogDatabase,
      $WineryTableTable,
      WineryRow,
      $$WineryTableTableFilterComposer,
      $$WineryTableTableOrderingComposer,
      $$WineryTableTableAnnotationComposer,
      $$WineryTableTableCreateCompanionBuilder,
      $$WineryTableTableUpdateCompanionBuilder,
      (WineryRow, $$WineryTableTableReferences),
      WineryRow,
      PrefetchHooks Function({bool wineTableRefs})
    >;
typedef $$WineTableTableCreateCompanionBuilder = WineTableCompanion Function({
  Value<int> id,
  required int wineryId,
  required String name,
  required WineType type,
  Value<List<String>> grapeVarieties,
});
typedef $$WineTableTableUpdateCompanionBuilder = WineTableCompanion Function({
  Value<int> id,
  Value<int> wineryId,
  Value<String> name,
  Value<WineType> type,
  Value<List<String>> grapeVarieties,
});

final class $$WineTableTableReferences
    extends BaseReferences<_$CatalogDatabase, $WineTableTable, WineRow> {
  $$WineTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WineryTableTable _wineryIdTable(_$CatalogDatabase db) =>
      db.wineryTable.createAlias('wine__winery_id__winery__id');

  $$WineryTableTableProcessedTableManager get wineryId {
    final $_column = $_itemColumn<int>('winery_id')!;

    final manager = $$WineryTableTableTableManager(
      $_db,
      $_db.wineryTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wineryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$VintageTableTable, List<VintageRow>>
  _vintageTableRefsTable(_$CatalogDatabase db) => MultiTypedResultKey.fromTable(
    db.vintageTable,
    aliasName: 'wine__id__vintage__wine_id',
  );

  $$VintageTableTableProcessedTableManager get vintageTableRefs {
    final manager = $$VintageTableTableTableManager(
      $_db,
      $_db.vintageTable,
    ).filter((f) => f.wineId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_vintageTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BarcodeTableTable, List<BarcodeRow>>
  _barcodeTableRefsTable(_$CatalogDatabase db) => MultiTypedResultKey.fromTable(
    db.barcodeTable,
    aliasName: 'wine__id__barcode__wine_id',
  );

  $$BarcodeTableTableProcessedTableManager get barcodeTableRefs {
    final manager = $$BarcodeTableTableTableManager(
      $_db,
      $_db.barcodeTable,
    ).filter((f) => f.wineId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_barcodeTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $WineTranslationTableTable,
    List<WineTranslationRow>
  >
  _wineTranslationTableRefsTable(_$CatalogDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.wineTranslationTable,
        aliasName: 'wine__id__wine_translation__wine_id',
      );

  $$WineTranslationTableTableProcessedTableManager
  get wineTranslationTableRefs {
    final manager = $$WineTranslationTableTableTableManager(
      $_db,
      $_db.wineTranslationTable,
    ).filter((f) => f.wineId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _wineTranslationTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WineTableTableFilterComposer
    extends Composer<_$CatalogDatabase, $WineTableTable> {
  $$WineTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<WineType, WineType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get grapeVarieties => $composableBuilder(
    column: $table.grapeVarieties,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$WineryTableTableFilterComposer get wineryId {
    final $$WineryTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wineryId,
      referencedTable: $db.wineryTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WineryTableTableFilterComposer(
            $db: $db,
            $table: $db.wineryTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> vintageTableRefs(
    Expression<bool> Function($$VintageTableTableFilterComposer f) f,
  ) {
    final $$VintageTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vintageTable,
      getReferencedColumn: (t) => t.wineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VintageTableTableFilterComposer(
            $db: $db,
            $table: $db.vintageTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> barcodeTableRefs(
    Expression<bool> Function($$BarcodeTableTableFilterComposer f) f,
  ) {
    final $$BarcodeTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.barcodeTable,
      getReferencedColumn: (t) => t.wineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BarcodeTableTableFilterComposer(
            $db: $db,
            $table: $db.barcodeTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> wineTranslationTableRefs(
    Expression<bool> Function($$WineTranslationTableTableFilterComposer f) f,
  ) {
    final $$WineTranslationTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wineTranslationTable,
      getReferencedColumn: (t) => t.wineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WineTranslationTableTableFilterComposer(
            $db: $db,
            $table: $db.wineTranslationTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WineTableTableOrderingComposer
    extends Composer<_$CatalogDatabase, $WineTableTable> {
  $$WineTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grapeVarieties => $composableBuilder(
    column: $table.grapeVarieties,
    builder: (column) => ColumnOrderings(column),
  );

  $$WineryTableTableOrderingComposer get wineryId {
    final $$WineryTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wineryId,
      referencedTable: $db.wineryTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WineryTableTableOrderingComposer(
            $db: $db,
            $table: $db.wineryTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WineTableTableAnnotationComposer
    extends Composer<_$CatalogDatabase, $WineTableTable> {
  $$WineTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<WineType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get grapeVarieties =>
      $composableBuilder(
        column: $table.grapeVarieties,
        builder: (column) => column,
      );

  $$WineryTableTableAnnotationComposer get wineryId {
    final $$WineryTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wineryId,
      referencedTable: $db.wineryTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WineryTableTableAnnotationComposer(
            $db: $db,
            $table: $db.wineryTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> vintageTableRefs<T extends Object>(
    Expression<T> Function($$VintageTableTableAnnotationComposer a) f,
  ) {
    final $$VintageTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vintageTable,
      getReferencedColumn: (t) => t.wineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VintageTableTableAnnotationComposer(
            $db: $db,
            $table: $db.vintageTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> barcodeTableRefs<T extends Object>(
    Expression<T> Function($$BarcodeTableTableAnnotationComposer a) f,
  ) {
    final $$BarcodeTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.barcodeTable,
      getReferencedColumn: (t) => t.wineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BarcodeTableTableAnnotationComposer(
            $db: $db,
            $table: $db.barcodeTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> wineTranslationTableRefs<T extends Object>(
    Expression<T> Function($$WineTranslationTableTableAnnotationComposer a) f,
  ) {
    final $$WineTranslationTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.wineTranslationTable,
          getReferencedColumn: (t) => t.wineId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WineTranslationTableTableAnnotationComposer(
                $db: $db,
                $table: $db.wineTranslationTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$WineTableTableTableManager
    extends
        RootTableManager<
          _$CatalogDatabase,
          $WineTableTable,
          WineRow,
          $$WineTableTableFilterComposer,
          $$WineTableTableOrderingComposer,
          $$WineTableTableAnnotationComposer,
          $$WineTableTableCreateCompanionBuilder,
          $$WineTableTableUpdateCompanionBuilder,
          (WineRow, $$WineTableTableReferences),
          WineRow,
          PrefetchHooks Function({
            bool wineryId,
            bool vintageTableRefs,
            bool barcodeTableRefs,
            bool wineTranslationTableRefs,
          })
        > {
  $$WineTableTableTableManager(_$CatalogDatabase db, $WineTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WineTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WineTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WineTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> wineryId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<WineType> type = const Value.absent(),
                Value<List<String>> grapeVarieties = const Value.absent(),
              }) => WineTableCompanion(
                id: id,
                wineryId: wineryId,
                name: name,
                type: type,
                grapeVarieties: grapeVarieties,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int wineryId,
                required String name,
                required WineType type,
                Value<List<String>> grapeVarieties = const Value.absent(),
              }) => WineTableCompanion.insert(
                id: id,
                wineryId: wineryId,
                name: name,
                type: type,
                grapeVarieties: grapeVarieties,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WineTableTable, WineRow>(table),
                  $$WineTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                wineryId = false,
                vintageTableRefs = false,
                barcodeTableRefs = false,
                wineTranslationTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (vintageTableRefs) db.vintageTable,
                    if (barcodeTableRefs) db.barcodeTable,
                    if (wineTranslationTableRefs) db.wineTranslationTable,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (wineryId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.wineryId,
                            referencedTable: $$WineTableTableReferences
                                ._wineryIdTable(db),
                            referencedColumn: $$WineTableTableReferences
                                ._wineryIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (vintageTableRefs)
                        await $_getPrefetchedData<
                          WineRow,
                          $WineTableTable,
                          VintageRow
                        >(
                          currentTable: table,
                          referencedTable: $$WineTableTableReferences
                              ._vintageTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WineTableTableReferences(
                                db,
                                table,
                                p0,
                              ).vintageTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.wineId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (barcodeTableRefs)
                        await $_getPrefetchedData<
                          WineRow,
                          $WineTableTable,
                          BarcodeRow
                        >(
                          currentTable: table,
                          referencedTable: $$WineTableTableReferences
                              ._barcodeTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WineTableTableReferences(
                                db,
                                table,
                                p0,
                              ).barcodeTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.wineId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (wineTranslationTableRefs)
                        await $_getPrefetchedData<
                          WineRow,
                          $WineTableTable,
                          WineTranslationRow
                        >(
                          currentTable: table,
                          referencedTable: $$WineTableTableReferences
                              ._wineTranslationTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WineTableTableReferences(
                                db,
                                table,
                                p0,
                              ).wineTranslationTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.wineId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$WineTableTableProcessedTableManager =
    ProcessedTableManager<
      _$CatalogDatabase,
      $WineTableTable,
      WineRow,
      $$WineTableTableFilterComposer,
      $$WineTableTableOrderingComposer,
      $$WineTableTableAnnotationComposer,
      $$WineTableTableCreateCompanionBuilder,
      $$WineTableTableUpdateCompanionBuilder,
      (WineRow, $$WineTableTableReferences),
      WineRow,
      PrefetchHooks Function({
        bool wineryId,
        bool vintageTableRefs,
        bool barcodeTableRefs,
        bool wineTranslationTableRefs,
      })
    >;
typedef $$VintageTableTableCreateCompanionBuilder =
    VintageTableCompanion Function({
      Value<int> id,
      required int wineId,
      required int year,
      Value<double?> abv,
      Value<double?> acidityGL,
      Value<double?> tanninsGL,
      Value<double?> residualSugarGL,
    });
typedef $$VintageTableTableUpdateCompanionBuilder =
    VintageTableCompanion Function({
      Value<int> id,
      Value<int> wineId,
      Value<int> year,
      Value<double?> abv,
      Value<double?> acidityGL,
      Value<double?> tanninsGL,
      Value<double?> residualSugarGL,
    });

final class $$VintageTableTableReferences
    extends BaseReferences<_$CatalogDatabase, $VintageTableTable, VintageRow> {
  $$VintageTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WineTableTable _wineIdTable(_$CatalogDatabase db) =>
      db.wineTable.createAlias('vintage__wine_id__wine__id');

  $$WineTableTableProcessedTableManager get wineId {
    final $_column = $_itemColumn<int>('wine_id')!;

    final manager = $$WineTableTableTableManager(
      $_db,
      $_db.wineTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$BarcodeTableTable, List<BarcodeRow>>
  _barcodeTableRefsTable(_$CatalogDatabase db) => MultiTypedResultKey.fromTable(
    db.barcodeTable,
    aliasName: 'vintage__id__barcode__vintage_id',
  );

  $$BarcodeTableTableProcessedTableManager get barcodeTableRefs {
    final manager = $$BarcodeTableTableTableManager(
      $_db,
      $_db.barcodeTable,
    ).filter((f) => f.vintageId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_barcodeTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $VintageTranslationTableTable,
    List<VintageTranslationRow>
  >
  _vintageTranslationTableRefsTable(_$CatalogDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.vintageTranslationTable,
        aliasName: 'vintage__id__vintage_translation__vintage_id',
      );

  $$VintageTranslationTableTableProcessedTableManager
  get vintageTranslationTableRefs {
    final manager = $$VintageTranslationTableTableTableManager(
      $_db,
      $_db.vintageTranslationTable,
    ).filter((f) => f.vintageId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _vintageTranslationTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VintageTableTableFilterComposer
    extends Composer<_$CatalogDatabase, $VintageTableTable> {
  $$VintageTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get abv => $composableBuilder(
    column: $table.abv,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get acidityGL => $composableBuilder(
    column: $table.acidityGL,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tanninsGL => $composableBuilder(
    column: $table.tanninsGL,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get residualSugarGL => $composableBuilder(
    column: $table.residualSugarGL,
    builder: (column) => ColumnFilters(column),
  );

  $$WineTableTableFilterComposer get wineId {
    final $$WineTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wineId,
      referencedTable: $db.wineTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WineTableTableFilterComposer(
            $db: $db,
            $table: $db.wineTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> barcodeTableRefs(
    Expression<bool> Function($$BarcodeTableTableFilterComposer f) f,
  ) {
    final $$BarcodeTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.barcodeTable,
      getReferencedColumn: (t) => t.vintageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BarcodeTableTableFilterComposer(
            $db: $db,
            $table: $db.barcodeTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> vintageTranslationTableRefs(
    Expression<bool> Function($$VintageTranslationTableTableFilterComposer f) f,
  ) {
    final $$VintageTranslationTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.vintageTranslationTable,
          getReferencedColumn: (t) => t.vintageId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$VintageTranslationTableTableFilterComposer(
                $db: $db,
                $table: $db.vintageTranslationTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$VintageTableTableOrderingComposer
    extends Composer<_$CatalogDatabase, $VintageTableTable> {
  $$VintageTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get abv => $composableBuilder(
    column: $table.abv,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get acidityGL => $composableBuilder(
    column: $table.acidityGL,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tanninsGL => $composableBuilder(
    column: $table.tanninsGL,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get residualSugarGL => $composableBuilder(
    column: $table.residualSugarGL,
    builder: (column) => ColumnOrderings(column),
  );

  $$WineTableTableOrderingComposer get wineId {
    final $$WineTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wineId,
      referencedTable: $db.wineTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WineTableTableOrderingComposer(
            $db: $db,
            $table: $db.wineTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VintageTableTableAnnotationComposer
    extends Composer<_$CatalogDatabase, $VintageTableTable> {
  $$VintageTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<double> get abv =>
      $composableBuilder(column: $table.abv, builder: (column) => column);

  GeneratedColumn<double> get acidityGL =>
      $composableBuilder(column: $table.acidityGL, builder: (column) => column);

  GeneratedColumn<double> get tanninsGL =>
      $composableBuilder(column: $table.tanninsGL, builder: (column) => column);

  GeneratedColumn<double> get residualSugarGL => $composableBuilder(
    column: $table.residualSugarGL,
    builder: (column) => column,
  );

  $$WineTableTableAnnotationComposer get wineId {
    final $$WineTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wineId,
      referencedTable: $db.wineTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WineTableTableAnnotationComposer(
            $db: $db,
            $table: $db.wineTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> barcodeTableRefs<T extends Object>(
    Expression<T> Function($$BarcodeTableTableAnnotationComposer a) f,
  ) {
    final $$BarcodeTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.barcodeTable,
      getReferencedColumn: (t) => t.vintageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BarcodeTableTableAnnotationComposer(
            $db: $db,
            $table: $db.barcodeTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> vintageTranslationTableRefs<T extends Object>(
    Expression<T> Function($$VintageTranslationTableTableAnnotationComposer a)
    f,
  ) {
    final $$VintageTranslationTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.vintageTranslationTable,
          getReferencedColumn: (t) => t.vintageId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$VintageTranslationTableTableAnnotationComposer(
                $db: $db,
                $table: $db.vintageTranslationTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$VintageTableTableTableManager
    extends
        RootTableManager<
          _$CatalogDatabase,
          $VintageTableTable,
          VintageRow,
          $$VintageTableTableFilterComposer,
          $$VintageTableTableOrderingComposer,
          $$VintageTableTableAnnotationComposer,
          $$VintageTableTableCreateCompanionBuilder,
          $$VintageTableTableUpdateCompanionBuilder,
          (VintageRow, $$VintageTableTableReferences),
          VintageRow,
          PrefetchHooks Function({
            bool wineId,
            bool barcodeTableRefs,
            bool vintageTranslationTableRefs,
          })
        > {
  $$VintageTableTableTableManager(
    _$CatalogDatabase db,
    $VintageTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VintageTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VintageTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VintageTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> wineId = const Value.absent(),
                Value<int> year = const Value.absent(),
                Value<double?> abv = const Value.absent(),
                Value<double?> acidityGL = const Value.absent(),
                Value<double?> tanninsGL = const Value.absent(),
                Value<double?> residualSugarGL = const Value.absent(),
              }) => VintageTableCompanion(
                id: id,
                wineId: wineId,
                year: year,
                abv: abv,
                acidityGL: acidityGL,
                tanninsGL: tanninsGL,
                residualSugarGL: residualSugarGL,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int wineId,
                required int year,
                Value<double?> abv = const Value.absent(),
                Value<double?> acidityGL = const Value.absent(),
                Value<double?> tanninsGL = const Value.absent(),
                Value<double?> residualSugarGL = const Value.absent(),
              }) => VintageTableCompanion.insert(
                id: id,
                wineId: wineId,
                year: year,
                abv: abv,
                acidityGL: acidityGL,
                tanninsGL: tanninsGL,
                residualSugarGL: residualSugarGL,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$VintageTableTable, VintageRow>(table),
                  $$VintageTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                wineId = false,
                barcodeTableRefs = false,
                vintageTranslationTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (barcodeTableRefs) db.barcodeTable,
                    if (vintageTranslationTableRefs) db.vintageTranslationTable,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (wineId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.wineId,
                            referencedTable: $$VintageTableTableReferences
                                ._wineIdTable(db),
                            referencedColumn: $$VintageTableTableReferences
                                ._wineIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (barcodeTableRefs)
                        await $_getPrefetchedData<
                          VintageRow,
                          $VintageTableTable,
                          BarcodeRow
                        >(
                          currentTable: table,
                          referencedTable: $$VintageTableTableReferences
                              ._barcodeTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VintageTableTableReferences(
                                db,
                                table,
                                p0,
                              ).barcodeTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vintageId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (vintageTranslationTableRefs)
                        await $_getPrefetchedData<
                          VintageRow,
                          $VintageTableTable,
                          VintageTranslationRow
                        >(
                          currentTable: table,
                          referencedTable: $$VintageTableTableReferences
                              ._vintageTranslationTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VintageTableTableReferences(
                                db,
                                table,
                                p0,
                              ).vintageTranslationTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vintageId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$VintageTableTableProcessedTableManager =
    ProcessedTableManager<
      _$CatalogDatabase,
      $VintageTableTable,
      VintageRow,
      $$VintageTableTableFilterComposer,
      $$VintageTableTableOrderingComposer,
      $$VintageTableTableAnnotationComposer,
      $$VintageTableTableCreateCompanionBuilder,
      $$VintageTableTableUpdateCompanionBuilder,
      (VintageRow, $$VintageTableTableReferences),
      VintageRow,
      PrefetchHooks Function({
        bool wineId,
        bool barcodeTableRefs,
        bool vintageTranslationTableRefs,
      })
    >;
typedef $$BarcodeTableTableCreateCompanionBuilder =
    BarcodeTableCompanion Function({
      Value<int> id,
      required String code,
      required int wineId,
      Value<int?> vintageId,
      Value<int?> bottleSizeMl,
    });
typedef $$BarcodeTableTableUpdateCompanionBuilder =
    BarcodeTableCompanion Function({
      Value<int> id,
      Value<String> code,
      Value<int> wineId,
      Value<int?> vintageId,
      Value<int?> bottleSizeMl,
    });

final class $$BarcodeTableTableReferences
    extends BaseReferences<_$CatalogDatabase, $BarcodeTableTable, BarcodeRow> {
  $$BarcodeTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WineTableTable _wineIdTable(_$CatalogDatabase db) =>
      db.wineTable.createAlias('barcode__wine_id__wine__id');

  $$WineTableTableProcessedTableManager get wineId {
    final $_column = $_itemColumn<int>('wine_id')!;

    final manager = $$WineTableTableTableManager(
      $_db,
      $_db.wineTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $VintageTableTable _vintageIdTable(_$CatalogDatabase db) =>
      db.vintageTable.createAlias('barcode__vintage_id__vintage__id');

  $$VintageTableTableProcessedTableManager? get vintageId {
    final $_column = $_itemColumn<int>('vintage_id');
    if ($_column == null) return null;
    final manager = $$VintageTableTableTableManager(
      $_db,
      $_db.vintageTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vintageIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BarcodeTableTableFilterComposer
    extends Composer<_$CatalogDatabase, $BarcodeTableTable> {
  $$BarcodeTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bottleSizeMl => $composableBuilder(
    column: $table.bottleSizeMl,
    builder: (column) => ColumnFilters(column),
  );

  $$WineTableTableFilterComposer get wineId {
    final $$WineTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wineId,
      referencedTable: $db.wineTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WineTableTableFilterComposer(
            $db: $db,
            $table: $db.wineTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VintageTableTableFilterComposer get vintageId {
    final $$VintageTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vintageId,
      referencedTable: $db.vintageTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VintageTableTableFilterComposer(
            $db: $db,
            $table: $db.vintageTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BarcodeTableTableOrderingComposer
    extends Composer<_$CatalogDatabase, $BarcodeTableTable> {
  $$BarcodeTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bottleSizeMl => $composableBuilder(
    column: $table.bottleSizeMl,
    builder: (column) => ColumnOrderings(column),
  );

  $$WineTableTableOrderingComposer get wineId {
    final $$WineTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wineId,
      referencedTable: $db.wineTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WineTableTableOrderingComposer(
            $db: $db,
            $table: $db.wineTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VintageTableTableOrderingComposer get vintageId {
    final $$VintageTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vintageId,
      referencedTable: $db.vintageTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VintageTableTableOrderingComposer(
            $db: $db,
            $table: $db.vintageTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BarcodeTableTableAnnotationComposer
    extends Composer<_$CatalogDatabase, $BarcodeTableTable> {
  $$BarcodeTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<int> get bottleSizeMl => $composableBuilder(
    column: $table.bottleSizeMl,
    builder: (column) => column,
  );

  $$WineTableTableAnnotationComposer get wineId {
    final $$WineTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wineId,
      referencedTable: $db.wineTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WineTableTableAnnotationComposer(
            $db: $db,
            $table: $db.wineTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VintageTableTableAnnotationComposer get vintageId {
    final $$VintageTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vintageId,
      referencedTable: $db.vintageTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VintageTableTableAnnotationComposer(
            $db: $db,
            $table: $db.vintageTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BarcodeTableTableTableManager
    extends
        RootTableManager<
          _$CatalogDatabase,
          $BarcodeTableTable,
          BarcodeRow,
          $$BarcodeTableTableFilterComposer,
          $$BarcodeTableTableOrderingComposer,
          $$BarcodeTableTableAnnotationComposer,
          $$BarcodeTableTableCreateCompanionBuilder,
          $$BarcodeTableTableUpdateCompanionBuilder,
          (BarcodeRow, $$BarcodeTableTableReferences),
          BarcodeRow,
          PrefetchHooks Function({bool wineId, bool vintageId})
        > {
  $$BarcodeTableTableTableManager(
    _$CatalogDatabase db,
    $BarcodeTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BarcodeTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BarcodeTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BarcodeTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<int> wineId = const Value.absent(),
                Value<int?> vintageId = const Value.absent(),
                Value<int?> bottleSizeMl = const Value.absent(),
              }) => BarcodeTableCompanion(
                id: id,
                code: code,
                wineId: wineId,
                vintageId: vintageId,
                bottleSizeMl: bottleSizeMl,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String code,
                required int wineId,
                Value<int?> vintageId = const Value.absent(),
                Value<int?> bottleSizeMl = const Value.absent(),
              }) => BarcodeTableCompanion.insert(
                id: id,
                code: code,
                wineId: wineId,
                vintageId: vintageId,
                bottleSizeMl: bottleSizeMl,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BarcodeTableTable, BarcodeRow>(table),
                  $$BarcodeTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({wineId = false, vintageId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (wineId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.wineId,
                        referencedTable: $$BarcodeTableTableReferences
                            ._wineIdTable(db),
                        referencedColumn: $$BarcodeTableTableReferences
                            ._wineIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (vintageId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.vintageId,
                        referencedTable: $$BarcodeTableTableReferences
                            ._vintageIdTable(db),
                        referencedColumn: $$BarcodeTableTableReferences
                            ._vintageIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$BarcodeTableTableProcessedTableManager =
    ProcessedTableManager<
      _$CatalogDatabase,
      $BarcodeTableTable,
      BarcodeRow,
      $$BarcodeTableTableFilterComposer,
      $$BarcodeTableTableOrderingComposer,
      $$BarcodeTableTableAnnotationComposer,
      $$BarcodeTableTableCreateCompanionBuilder,
      $$BarcodeTableTableUpdateCompanionBuilder,
      (BarcodeRow, $$BarcodeTableTableReferences),
      BarcodeRow,
      PrefetchHooks Function({bool wineId, bool vintageId})
    >;
typedef $$WineTranslationTableTableCreateCompanionBuilder =
    WineTranslationTableCompanion Function({
      required int wineId,
      required String lang,
      Value<String?> description,
      Value<int> rowid,
    });
typedef $$WineTranslationTableTableUpdateCompanionBuilder =
    WineTranslationTableCompanion Function({
      Value<int> wineId,
      Value<String> lang,
      Value<String?> description,
      Value<int> rowid,
    });

final class $$WineTranslationTableTableReferences
    extends
        BaseReferences<
          _$CatalogDatabase,
          $WineTranslationTableTable,
          WineTranslationRow
        > {
  $$WineTranslationTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WineTableTable _wineIdTable(_$CatalogDatabase db) =>
      db.wineTable.createAlias('wine_translation__wine_id__wine__id');

  $$WineTableTableProcessedTableManager get wineId {
    final $_column = $_itemColumn<int>('wine_id')!;

    final manager = $$WineTableTableTableManager(
      $_db,
      $_db.wineTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WineTranslationTableTableFilterComposer
    extends Composer<_$CatalogDatabase, $WineTranslationTableTable> {
  $$WineTranslationTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get lang => $composableBuilder(
    column: $table.lang,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  $$WineTableTableFilterComposer get wineId {
    final $$WineTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wineId,
      referencedTable: $db.wineTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WineTableTableFilterComposer(
            $db: $db,
            $table: $db.wineTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WineTranslationTableTableOrderingComposer
    extends Composer<_$CatalogDatabase, $WineTranslationTableTable> {
  $$WineTranslationTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get lang => $composableBuilder(
    column: $table.lang,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  $$WineTableTableOrderingComposer get wineId {
    final $$WineTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wineId,
      referencedTable: $db.wineTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WineTableTableOrderingComposer(
            $db: $db,
            $table: $db.wineTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WineTranslationTableTableAnnotationComposer
    extends Composer<_$CatalogDatabase, $WineTranslationTableTable> {
  $$WineTranslationTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get lang =>
      $composableBuilder(column: $table.lang, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  $$WineTableTableAnnotationComposer get wineId {
    final $$WineTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wineId,
      referencedTable: $db.wineTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WineTableTableAnnotationComposer(
            $db: $db,
            $table: $db.wineTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WineTranslationTableTableTableManager
    extends
        RootTableManager<
          _$CatalogDatabase,
          $WineTranslationTableTable,
          WineTranslationRow,
          $$WineTranslationTableTableFilterComposer,
          $$WineTranslationTableTableOrderingComposer,
          $$WineTranslationTableTableAnnotationComposer,
          $$WineTranslationTableTableCreateCompanionBuilder,
          $$WineTranslationTableTableUpdateCompanionBuilder,
          (WineTranslationRow, $$WineTranslationTableTableReferences),
          WineTranslationRow,
          PrefetchHooks Function({bool wineId})
        > {
  $$WineTranslationTableTableTableManager(
    _$CatalogDatabase db,
    $WineTranslationTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WineTranslationTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WineTranslationTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$WineTranslationTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> wineId = const Value.absent(),
                Value<String> lang = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WineTranslationTableCompanion(
                wineId: wineId,
                lang: lang,
                description: description,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int wineId,
                required String lang,
                Value<String?> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WineTranslationTableCompanion.insert(
                wineId: wineId,
                lang: lang,
                description: description,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WineTranslationTableTable, WineTranslationRow>(
                    table,
                  ),
                  $$WineTranslationTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({wineId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (wineId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.wineId,
                        referencedTable: $$WineTranslationTableTableReferences
                            ._wineIdTable(db),
                        referencedColumn: $$WineTranslationTableTableReferences
                            ._wineIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WineTranslationTableTableProcessedTableManager =
    ProcessedTableManager<
      _$CatalogDatabase,
      $WineTranslationTableTable,
      WineTranslationRow,
      $$WineTranslationTableTableFilterComposer,
      $$WineTranslationTableTableOrderingComposer,
      $$WineTranslationTableTableAnnotationComposer,
      $$WineTranslationTableTableCreateCompanionBuilder,
      $$WineTranslationTableTableUpdateCompanionBuilder,
      (WineTranslationRow, $$WineTranslationTableTableReferences),
      WineTranslationRow,
      PrefetchHooks Function({bool wineId})
    >;
typedef $$VintageTranslationTableTableCreateCompanionBuilder =
    VintageTranslationTableCompanion Function({
      required int vintageId,
      required String lang,
      Value<String?> sensoryNotes,
      Value<List<String>> foodPairings,
      Value<int> rowid,
    });
typedef $$VintageTranslationTableTableUpdateCompanionBuilder =
    VintageTranslationTableCompanion Function({
      Value<int> vintageId,
      Value<String> lang,
      Value<String?> sensoryNotes,
      Value<List<String>> foodPairings,
      Value<int> rowid,
    });

final class $$VintageTranslationTableTableReferences
    extends
        BaseReferences<
          _$CatalogDatabase,
          $VintageTranslationTableTable,
          VintageTranslationRow
        > {
  $$VintageTranslationTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VintageTableTable _vintageIdTable(_$CatalogDatabase db) => db
      .vintageTable
      .createAlias('vintage_translation__vintage_id__vintage__id');

  $$VintageTableTableProcessedTableManager get vintageId {
    final $_column = $_itemColumn<int>('vintage_id')!;

    final manager = $$VintageTableTableTableManager(
      $_db,
      $_db.vintageTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vintageIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VintageTranslationTableTableFilterComposer
    extends Composer<_$CatalogDatabase, $VintageTranslationTableTable> {
  $$VintageTranslationTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get lang => $composableBuilder(
    column: $table.lang,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sensoryNotes => $composableBuilder(
    column: $table.sensoryNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get foodPairings => $composableBuilder(
    column: $table.foodPairings,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$VintageTableTableFilterComposer get vintageId {
    final $$VintageTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vintageId,
      referencedTable: $db.vintageTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VintageTableTableFilterComposer(
            $db: $db,
            $table: $db.vintageTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VintageTranslationTableTableOrderingComposer
    extends Composer<_$CatalogDatabase, $VintageTranslationTableTable> {
  $$VintageTranslationTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get lang => $composableBuilder(
    column: $table.lang,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sensoryNotes => $composableBuilder(
    column: $table.sensoryNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get foodPairings => $composableBuilder(
    column: $table.foodPairings,
    builder: (column) => ColumnOrderings(column),
  );

  $$VintageTableTableOrderingComposer get vintageId {
    final $$VintageTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vintageId,
      referencedTable: $db.vintageTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VintageTableTableOrderingComposer(
            $db: $db,
            $table: $db.vintageTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VintageTranslationTableTableAnnotationComposer
    extends Composer<_$CatalogDatabase, $VintageTranslationTableTable> {
  $$VintageTranslationTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get lang =>
      $composableBuilder(column: $table.lang, builder: (column) => column);

  GeneratedColumn<String> get sensoryNotes => $composableBuilder(
    column: $table.sensoryNotes,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<String>, String> get foodPairings =>
      $composableBuilder(
        column: $table.foodPairings,
        builder: (column) => column,
      );

  $$VintageTableTableAnnotationComposer get vintageId {
    final $$VintageTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vintageId,
      referencedTable: $db.vintageTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VintageTableTableAnnotationComposer(
            $db: $db,
            $table: $db.vintageTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VintageTranslationTableTableTableManager
    extends
        RootTableManager<
          _$CatalogDatabase,
          $VintageTranslationTableTable,
          VintageTranslationRow,
          $$VintageTranslationTableTableFilterComposer,
          $$VintageTranslationTableTableOrderingComposer,
          $$VintageTranslationTableTableAnnotationComposer,
          $$VintageTranslationTableTableCreateCompanionBuilder,
          $$VintageTranslationTableTableUpdateCompanionBuilder,
          (VintageTranslationRow, $$VintageTranslationTableTableReferences),
          VintageTranslationRow,
          PrefetchHooks Function({bool vintageId})
        > {
  $$VintageTranslationTableTableTableManager(
    _$CatalogDatabase db,
    $VintageTranslationTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VintageTranslationTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$VintageTranslationTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$VintageTranslationTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> vintageId = const Value.absent(),
                Value<String> lang = const Value.absent(),
                Value<String?> sensoryNotes = const Value.absent(),
                Value<List<String>> foodPairings = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VintageTranslationTableCompanion(
                vintageId: vintageId,
                lang: lang,
                sensoryNotes: sensoryNotes,
                foodPairings: foodPairings,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int vintageId,
                required String lang,
                Value<String?> sensoryNotes = const Value.absent(),
                Value<List<String>> foodPairings = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VintageTranslationTableCompanion.insert(
                vintageId: vintageId,
                lang: lang,
                sensoryNotes: sensoryNotes,
                foodPairings: foodPairings,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $VintageTranslationTableTable,
                    VintageTranslationRow
                  >(table),
                  $$VintageTranslationTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vintageId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vintageId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.vintageId,
                        referencedTable:
                            $$VintageTranslationTableTableReferences
                                ._vintageIdTable(db),
                        referencedColumn:
                            $$VintageTranslationTableTableReferences
                                ._vintageIdTable(db)
                                .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$VintageTranslationTableTableProcessedTableManager =
    ProcessedTableManager<
      _$CatalogDatabase,
      $VintageTranslationTableTable,
      VintageTranslationRow,
      $$VintageTranslationTableTableFilterComposer,
      $$VintageTranslationTableTableOrderingComposer,
      $$VintageTranslationTableTableAnnotationComposer,
      $$VintageTranslationTableTableCreateCompanionBuilder,
      $$VintageTranslationTableTableUpdateCompanionBuilder,
      (VintageTranslationRow, $$VintageTranslationTableTableReferences),
      VintageTranslationRow,
      PrefetchHooks Function({bool vintageId})
    >;
typedef $$MetaTableTableCreateCompanionBuilder = MetaTableCompanion Function({
  required int dataVersion,
  required int schemaVersion,
  required String builtAt,
  Value<int> rowid,
});
typedef $$MetaTableTableUpdateCompanionBuilder = MetaTableCompanion Function({
  Value<int> dataVersion,
  Value<int> schemaVersion,
  Value<String> builtAt,
  Value<int> rowid,
});

class $$MetaTableTableFilterComposer
    extends Composer<_$CatalogDatabase, $MetaTableTable> {
  $$MetaTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get dataVersion => $composableBuilder(
    column: $table.dataVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get schemaVersion => $composableBuilder(
    column: $table.schemaVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get builtAt => $composableBuilder(
    column: $table.builtAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MetaTableTableOrderingComposer
    extends Composer<_$CatalogDatabase, $MetaTableTable> {
  $$MetaTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get dataVersion => $composableBuilder(
    column: $table.dataVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get schemaVersion => $composableBuilder(
    column: $table.schemaVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get builtAt => $composableBuilder(
    column: $table.builtAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MetaTableTableAnnotationComposer
    extends Composer<_$CatalogDatabase, $MetaTableTable> {
  $$MetaTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get dataVersion => $composableBuilder(
    column: $table.dataVersion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get schemaVersion => $composableBuilder(
    column: $table.schemaVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get builtAt =>
      $composableBuilder(column: $table.builtAt, builder: (column) => column);
}

class $$MetaTableTableTableManager
    extends
        RootTableManager<
          _$CatalogDatabase,
          $MetaTableTable,
          MetaRow,
          $$MetaTableTableFilterComposer,
          $$MetaTableTableOrderingComposer,
          $$MetaTableTableAnnotationComposer,
          $$MetaTableTableCreateCompanionBuilder,
          $$MetaTableTableUpdateCompanionBuilder,
          (
            MetaRow,
            BaseReferences<_$CatalogDatabase, $MetaTableTable, MetaRow>,
          ),
          MetaRow,
          PrefetchHooks Function()
        > {
  $$MetaTableTableTableManager(_$CatalogDatabase db, $MetaTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MetaTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MetaTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MetaTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> dataVersion = const Value.absent(),
                Value<int> schemaVersion = const Value.absent(),
                Value<String> builtAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MetaTableCompanion(
                dataVersion: dataVersion,
                schemaVersion: schemaVersion,
                builtAt: builtAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int dataVersion,
                required int schemaVersion,
                required String builtAt,
                Value<int> rowid = const Value.absent(),
              }) => MetaTableCompanion.insert(
                dataVersion: dataVersion,
                schemaVersion: schemaVersion,
                builtAt: builtAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MetaTableTable, MetaRow>(table),
                  BaseReferences<_$CatalogDatabase, $MetaTableTable, MetaRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MetaTableTableProcessedTableManager =
    ProcessedTableManager<
      _$CatalogDatabase,
      $MetaTableTable,
      MetaRow,
      $$MetaTableTableFilterComposer,
      $$MetaTableTableOrderingComposer,
      $$MetaTableTableAnnotationComposer,
      $$MetaTableTableCreateCompanionBuilder,
      $$MetaTableTableUpdateCompanionBuilder,
      (MetaRow, BaseReferences<_$CatalogDatabase, $MetaTableTable, MetaRow>),
      MetaRow,
      PrefetchHooks Function()
    >;

class $CatalogDatabaseManager {
  final _$CatalogDatabase _db;
  $CatalogDatabaseManager(this._db);
  $$WineryTableTableTableManager get wineryTable =>
      $$WineryTableTableTableManager(_db, _db.wineryTable);
  $$WineTableTableTableManager get wineTable =>
      $$WineTableTableTableManager(_db, _db.wineTable);
  $$VintageTableTableTableManager get vintageTable =>
      $$VintageTableTableTableManager(_db, _db.vintageTable);
  $$BarcodeTableTableTableManager get barcodeTable =>
      $$BarcodeTableTableTableManager(_db, _db.barcodeTable);
  $$WineTranslationTableTableTableManager get wineTranslationTable =>
      $$WineTranslationTableTableTableManager(_db, _db.wineTranslationTable);
  $$VintageTranslationTableTableTableManager get vintageTranslationTable =>
      $$VintageTranslationTableTableTableManager(
        _db,
        _db.vintageTranslationTable,
      );
  $$MetaTableTableTableManager get metaTable =>
      $$MetaTableTableTableManager(_db, _db.metaTable);
}
