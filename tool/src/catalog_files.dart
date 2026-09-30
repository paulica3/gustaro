import 'dart:io';

import 'package:csv/csv.dart';

import 'catalog_builder.dart';

/// One CSV file, editable in memory. Keeps the original header and any
/// extra columns (e.g. your own notes) when written back.
class CsvTable {
  CsvTable(this.header, this.rows);

  factory CsvTable.parse(String content) {
    final text = content.startsWith('﻿') ? content.substring(1) : content;
    final parsed = Csv(skipEmptyLines: false).decode(text);
    if (parsed.isEmpty) return CsvTable([], []);
    return CsvTable(
      [for (final cell in parsed.first) cell.toString()],
      [
        for (final row in parsed.skip(1))
          if (row.any((cell) => cell.toString().trim().isNotEmpty))
            [for (final cell in row) cell.toString()],
      ],
    );
  }

  final List<String> header;
  final List<List<String>> rows;

  List<String> get _keys => [for (final h in header) h.trim().toLowerCase()];

  /// Rows as column → trimmed value.
  List<Map<String, String>> get records {
    final keys = _keys;
    return [
      for (final row in rows)
        {
          for (var i = 0; i < keys.length; i++)
            keys[i]: i < row.length ? row[i].trim() : '',
        },
    ];
  }

  /// Appends a row; columns not in [record] are left empty.
  void add(Map<String, String> record) {
    final keys = _keys;
    final unknown = record.keys.where((k) => !keys.contains(k));
    if (unknown.isNotEmpty) {
      throw ArgumentError('unknown column(s): ${unknown.join(', ')}');
    }
    rows.add([for (final key in keys) record[key] ?? '']);
  }

  /// UTF-8 with BOM so Excel shows diacritics correctly when opening it.
  String encode() =>
      '${Csv(lineDelimiter: '\n', addBom: true).encode([header, ...rows])}\n';
}

/// All catalogue CSV files of one data directory.
class CatalogFiles {
  CatalogFiles(this.tables);

  /// A missing file is treated as empty, with the standard columns.
  factory CatalogFiles.load(String dataDir) => CatalogFiles({
    for (final MapEntry(key: name, value: columns) in catalogFiles.entries)
      name: File('$dataDir/$name').existsSync()
          ? CsvTable.parse(File('$dataDir/$name').readAsStringSync())
          : CsvTable([...columns], []),
  });

  final Map<String, CsvTable> tables;

  CsvTable operator [](String file) => tables[file]!;

  List<Map<String, String>> records(String file) => tables[file]!.records;

  /// One more than the highest numeric [column] value in [file].
  int nextId(String file, [String column = 'id']) {
    var max = 0;
    for (final record in records(file)) {
      final id = int.tryParse(record[column] ?? '');
      if (id != null && id > max) max = id;
    }
    return max + 1;
  }

  Map<String, String> toCsvStrings() => {
    for (final MapEntry(key: name, value: table) in tables.entries)
      name: table.encode(),
  };

  /// Writes every file via a temporary file + rename, so an interrupted
  /// save never leaves a half-written CSV.
  void save(String dataDir) {
    Directory(dataDir).createSync(recursive: true);
    for (final MapEntry(key: name, value: content) in toCsvStrings().entries) {
      final tmp = File('$dataDir/$name.tmp')..writeAsStringSync(content);
      tmp.renameSync('$dataDir/$name');
    }
  }
}
