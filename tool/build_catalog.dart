// Builds the bundled catalogue from the CSV files.
//
//   dart run tool/build_catalog.dart [--data data] [--out assets/catalog.sqlite]
//
// Exits with code 1 and writes nothing if validation fails.
import 'dart:io';

import 'src/build_catalog_file.dart';

Future<void> main(List<String> args) async {
  final options = _parseArgs(args);
  final ok = await buildCatalogFile(
    options['--data'] ?? 'data',
    options['--out'] ?? 'assets/catalog.sqlite',
  );
  if (!ok) exit(1);
}

Map<String, String> _parseArgs(List<String> args) {
  final options = <String, String>{};
  for (var i = 0; i + 1 < args.length; i += 2) {
    options[args[i]] = args[i + 1];
  }
  return options;
}
