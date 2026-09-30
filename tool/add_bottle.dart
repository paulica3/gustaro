// Adds one bottle to the catalogue CSVs by asking questions, then rebuilds
// the catalogue.
//
//   dart run tool/add_bottle.dart [--data data] [--out assets/catalog.sqlite]
import 'dart:convert';
import 'dart:io';

import 'src/bottle_wizard.dart';
import 'src/build_catalog_file.dart';
import 'src/catalog_builder.dart';
import 'src/catalog_files.dart';

Future<void> main(List<String> args) async {
  final options = <String, String>{
    for (var i = 0; i + 1 < args.length; i += 2) args[i]: args[i + 1],
  };
  final dataDir = options['--data'] ?? 'data';
  final outPath = options['--out'] ?? 'assets/catalog.sqlite';
  final console = _StdConsole();

  while (true) {
    final files = CatalogFiles.load(dataDir);

    // Refuse to add on top of files that are already broken.
    final before = validateCatalog(files.toCsvStrings());
    if (!before.isValid) {
      stderr.writeln('The CSV files already have errors; fix them first:');
      for (final e in before.errors) {
        stderr.writeln('  $e');
      }
      exit(1);
    }

    final BottlePlan? plan;
    try {
      plan = runBottleWizard(files, console);
    } on WizardAborted {
      stdout.writeln('\nCancelled, nothing saved.');
      exit(0);
    }

    if (plan == null) {
      stdout.writeln('Nothing saved.');
    } else {
      plan.applyTo(files);
      final after = validateCatalog(files.toCsvStrings());
      if (!after.isValid) {
        // Should not happen: the wizard only produces valid rows.
        stderr.writeln('Not saved, the result would be invalid:');
        for (final e in after.errors) {
          stderr.writeln('  $e');
        }
        exit(1);
      }
      files.save(dataDir);
      stdout.writeln('Saved to $dataDir/.');
      if (!await buildCatalogFile(dataDir, outPath)) exit(1);
    }

    stdout.write('\nAdd another bottle? [y/N] ');
    final again = stdin.readLineSync(encoding: utf8)?.trim().toLowerCase();
    if (again != 'y' && again != 'yes' && again != 'da') break;
  }

  stdout.writeln(
    '\nReinstall the app to see the changes:\n'
    '  flutter run --release -d "<your iPhone>"',
  );
}

class _StdConsole implements Console {
  @override
  String? readLine() => stdin.readLineSync(encoding: utf8);

  @override
  void write(String text) => stdout.write(text);
}
