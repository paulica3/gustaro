import 'package:flutter_test/flutter_test.dart';

import '../../tool/src/bottle_wizard.dart';
import '../../tool/src/catalog_builder.dart';
import '../../tool/src/catalog_files.dart';

/// Replays scripted answers and records everything the wizard printed.
class ScriptedConsole implements Console {
  ScriptedConsole(List<String> answers) : _answers = List.of(answers);

  final List<String> _answers;
  final output = StringBuffer();

  @override
  String? readLine() => _answers.isEmpty ? null : _answers.removeAt(0);

  @override
  void write(String text) => output.write(text);

  bool get allAnswersUsed => _answers.isEmpty;
}

CatalogFiles emptyFiles() => CatalogFiles({
  for (final MapEntry(key: file, value: columns) in catalogFiles.entries)
    file: CsvTable([...columns], []),
});

/// One winery, one wine, one vintage, one "every year" barcode.
CatalogFiles existingFiles() => CatalogFiles({
  'wineries.csv': CsvTable.parse('id,name,region\n1,Crama Țărăncuța,Codru\n'),
  'wines.csv': CsvTable.parse(
    'id,winery_id,name,type,grape_varieties\n10,1,Fetească Neagră,red,\n',
  ),
  'vintages.csv': CsvTable.parse(
    'id,wine_id,year,abv,acidity_g_l,tannins_g_l,residual_sugar_g_l\n'
    '101,10,2020,,,,\n',
  ),
  'barcodes.csv': CsvTable.parse(
    'code,wine_id,vintage_id,bottle_size_ml\n4841000000012,10,,750\n',
  ),
  'wine_translations.csv': CsvTable.parse(
    'wine_id,lang,description\n10,ro,Sec.\n',
  ),
  'vintage_translations.csv': CsvTable.parse(
    'vintage_id,lang,sensory_notes,food_pairings\n101,ro,Vișine.,\n',
  ),
});

/// Runs the wizard, applies the plan, and checks the result validates.
CatalogFiles addBottle(CatalogFiles files, List<String> answers) {
  final console = ScriptedConsole(answers);
  final plan = runBottleWizard(files, console, now: DateTime(2026, 9));
  expect(plan, isNotNull, reason: console.output.toString());
  expect(console.allAnswersUsed, isTrue, reason: console.output.toString());
  plan!.applyTo(files);
  final build = validateCatalog(files.toCsvStrings(), now: DateTime(2026, 9));
  expect(build.errors, isEmpty);
  return files;
}

void main() {
  group('gtinCheckDigitValid', () {
    test('valid EAN-13, UPC-A and EAN-8', () {
      expect(gtinCheckDigitValid('4006381333931'), isTrue);
      expect(gtinCheckDigitValid('036000291452'), isTrue);
      expect(gtinCheckDigitValid('96385074'), isTrue);
    });

    test('one wrong digit is caught', () {
      expect(gtinCheckDigitValid('4006381333932'), isFalse);
      expect(gtinCheckDigitValid('4006381343931'), isFalse);
    });

    test('internal codes are not checkable', () {
      expect(gtinCheckDigitValid('MD-0042'), isNull);
      expect(gtinCheckDigitValid('12345'), isNull);
    });
  });

  test('first bottle in an empty catalogue creates every row', () {
    final files = addBottle(emptyFiles(), [
      '4841000000029', // barcode
      'Crama Țărăncuța', // winery
      'Codru', // region
      'Rară Neagră', // wine
      '1', // type: red
      'Rară Neagră, Fetească Neagră', // grapes
      'Vin roșu sec.', // description
      '2021', // year
      '13,5', // abv, decimal comma
      '', '', '2', // acidity, tannins, sugar
      'Prune, piper.', // sensory notes
      'Miel', 'Brânză maturată', '', // pairings
      '', // every year? default yes
      '', // size default 750
      'y', // save
    ]);
    expect(files.records('wineries.csv').single, {
      'id': '1',
      'name': 'Crama Țărăncuța',
      'region': 'Codru',
    });
    expect(
      files.records('wines.csv').single['grape_varieties'],
      'Rară Neagră | Fetească Neagră',
    );
    expect(files.records('vintages.csv').single['abv'], '13.5');
    expect(
      files.records('vintage_translations.csv').single['food_pairings'],
      'Miel | Brânză maturată',
    );
    expect(files.records('barcodes.csv').single, {
      'code': '4841000000029',
      'wine_id': '1',
      'vintage_id': '',
      'bottle_size_ml': '750',
    });
  });

  test(
    'existing winery is found without diacritics; new wine gets next ids',
    () {
      final files = addBottle(existingFiles(), [
        '4841000000036',
        'crama tarancuta', // matches "Crama Țărăncuța"
        'Viorica',
        '2', // white
        '',
        '',
        '2023',
        '12', '', '', '', '', '',
        'n', // only this year
        '',
        'y',
      ]);
      expect(files.records('wineries.csv').length, 1);
      final wine = files.records('wines.csv').last;
      expect(wine, containsPair('id', '11'));
      expect(wine, containsPair('winery_id', '1'));
      expect(wine, containsPair('type', 'white'));
      expect(files.records('vintages.csv').last, containsPair('id', '102'));
      expect(
        files.records('barcodes.csv').last,
        containsPair('vintage_id', '102'),
      );
    },
  );

  test('a typo in the winery name offers the existing one', () {
    final console = ScriptedConsole([
      '',
      'Crama Taranuta', // typo
      'y', // did you mean Crama Țărăncuța? yes
      'Fetească Neagră',
      '2021',
      '', '', '', '', '', '',
      'y',
    ]);
    final plan = runBottleWizard(
      existingFiles(),
      console,
      now: DateTime(2026, 9),
    )!;
    expect(
      console.output.toString(),
      contains('Did you mean winery "Crama Țărăncuța"'),
    );
    expect(plan.rows.keys, isNot(contains('wineries.csv')));
    expect(plan.rows.keys, isNot(contains('wines.csv')));
    expect(plan.rows['vintages.csv']!.single['year'], '2021');
  });

  test(
    'new year of a wine whose barcode covers every year: no barcode question',
    () {
      final console = ScriptedConsole([
        '4841000000012',
        'Crama Țărăncuța',
        'Fetească Neagră',
        '2022',
        '',
        '',
        '',
        '',
        '',
        '',
        'y',
      ]);
      final plan = runBottleWizard(
        existingFiles(),
        console,
        now: DateTime(2026, 9),
      )!;
      expect(console.allAnswersUsed, isTrue);
      expect(console.output.toString(), contains('already covers every year'));
      expect(plan.rows.keys, isNot(contains('barcodes.csv')));
    },
  );

  test('existing vintage and no barcode: nothing to add', () {
    final console = ScriptedConsole([
      '',
      'Crama Țărăncuța',
      'Fetească Neagră',
      '2020',
    ]);
    expect(
      runBottleWizard(existingFiles(), console, now: DateTime(2026, 9)),
      isNull,
    );
    expect(console.output.toString(), contains('Nothing new to add'));
  });

  test('wrong check digit asks again', () {
    final console = ScriptedConsole([
      '4841000000013', // typo
      'n', // don't use it
      '4841000000029',
      'Crama Țărăncuța',
      'Fetească Neagră',
      '2020',
      '', // every year
      '',
      'y',
    ]);
    final plan = runBottleWizard(
      existingFiles(),
      console,
      now: DateTime(2026, 9),
    )!;
    expect(console.output.toString(), contains('check digit'));
    expect(plan.rows['barcodes.csv']!.single['code'], '4841000000029');
  });

  test('invalid answers are asked again', () {
    final console = ScriptedConsole([
      '',
      'Crama Țărăncuța',
      'Fetească Neagră',
      '1820', // out of range
      'abc', // not a number
      '2021',
      'strong', '14', // abv
      '', '', '', '', '',
      'y',
    ]);
    final plan = runBottleWizard(
      existingFiles(),
      console,
      now: DateTime(2026, 9),
    )!;
    expect(plan.rows['vintages.csv']!.single, containsPair('abv', '14'));
    expect(plan.rows['vintages.csv']!.single, containsPair('year', '2021'));
  });

  test('declining to save returns nothing', () {
    final console = ScriptedConsole([
      '',
      'Crama Țărăncuța',
      'Fetească Neagră',
      '2021',
      '',
      '',
      '',
      '',
      '',
      '',
      'n',
    ]);
    expect(
      runBottleWizard(existingFiles(), console, now: DateTime(2026, 9)),
      isNull,
    );
  });

  test('input ending mid-way aborts', () {
    expect(
      () => runBottleWizard(existingFiles(), ScriptedConsole(['', 'Crama X'])),
      throwsA(isA<WizardAborted>()),
    );
  });

  group('CsvTable', () {
    test(
      'keeps extra columns and rewrites semicolon files with commas + BOM',
      () {
        final table = CsvTable.parse(
          'id;name;region;notes\n1;Crama "A";Codru;call back\n',
        );
        table.add({'id': '2', 'name': 'B, C', 'region': ''});
        final encoded = table.encode();
        expect(encoded, startsWith('﻿'));
        final reparsed = CsvTable.parse(encoded);
        expect(reparsed.records, [
          {
            'id': '1',
            'name': 'Crama "A"',
            'region': 'Codru',
            'notes': 'call back',
          },
          {'id': '2', 'name': 'B, C', 'region': '', 'notes': ''},
        ]);
      },
    );

    test('rejects unknown columns', () {
      final table = CsvTable.parse('id,name\n');
      expect(() => table.add({'color': 'red'}), throwsArgumentError);
    });
  });
}
