import 'dart:io';

import 'package:drift/native.dart';
import 'package:gustaro/src/catalog/catalog_database.dart';

import 'catalog_builder.dart';

/// Validates the CSVs in [dataDir] and writes the SQLite catalogue to
/// [outPath]. Prints warnings and errors; returns false (writing nothing)
/// if there is any error.
Future<bool> buildCatalogFile(String dataDir, String outPath) async {
  if (!Directory(dataDir).existsSync()) {
    stderr.writeln('error: data directory "$dataDir" not found');
    return false;
  }

  final files = <String, String>{};
  for (final name in catalogFiles.keys) {
    final file = File('$dataDir/$name');
    if (file.existsSync()) files[name] = file.readAsStringSync();
  }

  final build = validateCatalog(files);
  for (final warning in build.warnings) {
    stdout.writeln('warning: $warning');
  }
  if (!build.isValid) {
    for (final error in build.errors) {
      stderr.writeln('error: $error');
    }
    stderr.writeln('${build.errors.length} error(s); nothing written.');
    return false;
  }

  final now = DateTime.now().toUtc();
  // Monotonic and readable: 202610011230 = 2026-10-01 12:30 UTC.
  final dataVersion = int.parse(
    now.toIso8601String().substring(0, 16).replaceAll(RegExp(r'[^0-9]'), ''),
  );

  // Write to a temporary file, then rename: never leaves a half-built file.
  final tmp = File('$outPath.tmp');
  if (tmp.existsSync()) tmp.deleteSync();
  tmp.parent.createSync(recursive: true);
  final db = CatalogDatabase(NativeDatabase(tmp));
  await writeCatalog(build, db, dataVersion: dataVersion, builtAt: now);
  await db.close();
  tmp.renameSync(outPath);

  stdout.writeln(
    'Wrote $outPath: ${build.wines.length} wines, '
    '${build.vintages.length} vintages, ${build.barcodes.length} barcodes, '
    'data_version $dataVersion.',
  );
  return true;
}
