import 'package:gustaro/src/catalog/models.dart';
import 'package:gustaro/src/scan/label_matcher.dart' show similarity;
import 'package:gustaro/src/scan/text_normalizer.dart';

import 'catalog_files.dart';

/// Where the wizard reads answers and writes questions. Lets tests script
/// a whole session.
abstract interface class Console {
  /// Null when input ended (Ctrl+D).
  String? readLine();
  void write(String text);
}

/// Thrown when input ends mid-session. Nothing has been saved.
class WizardAborted implements Exception {}

/// Rows to append, per CSV file, plus a human-readable summary.
final class BottlePlan {
  final rows = <String, List<Map<String, String>>>{};
  final summary = <String>[];

  void add(String file, Map<String, String> record) =>
      (rows[file] ??= []).add(record);

  bool get isEmpty => rows.isEmpty;

  void applyTo(CatalogFiles files) {
    for (final MapEntry(key: file, value: records) in rows.entries) {
      records.forEach(files[file].add);
    }
  }
}

/// Names this close (0..1, after normalization) are offered as "did you
/// mean", to avoid a duplicate winery or wine because of a typo.
const _similarNameThreshold = 0.8;

/// Asks for one bottle and returns what to add, or null if the user
/// cancelled or there was nothing new. Does not modify [files].
BottlePlan? runBottleWizard(CatalogFiles files, Console io, {DateTime? now}) {
  final ask = _Ask(io);
  final plan = BottlePlan();
  final maxYear = (now ?? DateTime.now()).year + 1;

  io.write(
    '\n== Add a bottle ==\n'
    'Press Enter to skip optional questions. Nothing is saved until you '
    'confirm at the end.\n\n',
  );

  // Barcode ---------------------------------------------------------------
  final code = _askBarcode(ask, files);

  // Winery ----------------------------------------------------------------
  final wineries = files.records('wineries.csv');
  final wineryName = ask.text('Winery name:', required: true)!;
  var winery = _pickExisting(ask, wineryName, wineries, 'winery');
  final String wineryId;
  if (winery != null) {
    wineryId = winery['id']!;
    io.write('  → existing winery #$wineryId ${winery['name']}\n');
  } else {
    wineryId = '${files.nextId('wineries.csv')}';
    final region = ask.text(
      'Region (e.g. Codru, Ștefan Vodă, Valul lui Traian):',
    );
    winery = {'id': wineryId, 'name': wineryName, 'region': region ?? ''};
    plan.add('wineries.csv', winery);
    plan.summary.add('New winery #$wineryId: $wineryName (${region ?? '—'})');
  }

  // Wine ------------------------------------------------------------------
  final wines = files
      .records('wines.csv')
      .where((w) => w['winery_id'] == wineryId)
      .toList();
  if (wines.isNotEmpty) {
    io.write(
      '  Wines of this winery: ${wines.map((w) => w['name']).join(', ')}\n',
    );
  }
  final wineName = ask.text('Wine name (as on the label):', required: true)!;
  final existingWine = _pickExisting(ask, wineName, wines, 'wine');
  final String wineId;
  if (existingWine != null) {
    wineId = existingWine['id']!;
    io.write('  → existing wine #$wineId ${existingWine['name']}\n');
  } else {
    wineId = '${files.nextId('wines.csv')}';
    final type = ask.choice('Type:', [
      for (final t in WineType.values) (t.name, t.name),
    ]);
    final grapes = ask.list('Grape varieties (separate with commas):');
    final description = ask.text('Description (Romanian):');
    plan.add('wines.csv', {
      'id': wineId,
      'winery_id': wineryId,
      'name': wineName,
      'type': type,
      'grape_varieties': grapes.join(' | '),
    });
    plan.add('wine_translations.csv', {
      'wine_id': wineId,
      'lang': 'ro',
      'description': description ?? '',
    });
    plan.summary.add(
      'New wine #$wineId: $wineName, $type, '
      '${grapes.isEmpty ? 'grapes —' : grapes.join(', ')}',
    );
  }

  // Vintage ---------------------------------------------------------------
  final year = ask.integer('Year (harvest):', min: 1900, max: maxYear)!;
  final existingVintage = files
      .records('vintages.csv')
      .where((v) => v['wine_id'] == wineId && v['year'] == '$year')
      .firstOrNull;
  final String vintageId;
  if (existingVintage != null) {
    vintageId = existingVintage['id']!;
    io.write(
      '  → $year already exists (#$vintageId); its data is not changed.\n',
    );
  } else {
    vintageId = '${files.nextId('vintages.csv')}';
    final abv = ask.decimal('Alcohol % (e.g. 13,5):', max: 100);
    final acidity = ask.decimal('Acidity g/L:');
    final tannins = ask.decimal('Tannins g/L:');
    final sugar = ask.decimal('Residual sugar g/L:');
    final notes = ask.text('Sensory notes (Romanian):');
    final pairings = ask.lines(
      'Food pairings (Romanian), one per line, empty line to finish:',
    );
    plan.add('vintages.csv', {
      'id': vintageId,
      'wine_id': wineId,
      'year': '$year',
      'abv': abv ?? '',
      'acidity_g_l': acidity ?? '',
      'tannins_g_l': tannins ?? '',
      'residual_sugar_g_l': sugar ?? '',
    });
    plan.add('vintage_translations.csv', {
      'vintage_id': vintageId,
      'lang': 'ro',
      'sensory_notes': notes ?? '',
      'food_pairings': pairings.join(' | '),
    });
    plan.summary.add(
      'New vintage #$vintageId: $year, alcohol ${abv ?? '—'}%, '
      '${pairings.length} pairing(s)',
    );
  }

  // Barcode row -----------------------------------------------------------
  if (code != null) {
    final barcodes = files.records('barcodes.csv');
    final coversAllYears = barcodes.any(
      (b) =>
          b['code'] == code &&
          b['wine_id'] == wineId &&
          b['vintage_id']!.isEmpty,
    );
    if (coversAllYears) {
      io.write('  → barcode $code already covers every year of this wine.\n');
    } else {
      final everyYear = ask.yesNo(
        'Is this barcode the same on every year of this wine? '
        '(if unsure, answer yes: users then pick the year)',
        defaultYes: true,
      );
      final size = ask.integer('Bottle size in ml:', min: 1, defaultValue: 750);
      final record = {
        'code': code,
        'wine_id': wineId,
        'vintage_id': everyYear ? '' : vintageId,
        'bottle_size_ml': size == null ? '' : '$size',
      };
      final duplicate = barcodes.any(
        (b) => record.entries.every((e) => b[e.key] == e.value),
      );
      if (duplicate) {
        io.write('  → this exact barcode row already exists.\n');
      } else {
        plan.add('barcodes.csv', record);
        plan.summary.add(
          'Barcode $code → wine #$wineId, '
          '${everyYear ? 'every year' : 'only $year'}, ${size ?? '—'} ml',
        );
      }
    }
  }

  // Confirm ---------------------------------------------------------------
  if (plan.isEmpty) {
    io.write('\nNothing new to add.\n');
    return null;
  }
  io.write('\nAbout to add:\n');
  for (final line in plan.summary) {
    io.write('  • $line\n');
  }
  return ask.yesNo('Save?', defaultYes: false) ? plan : null;
}

String? _askBarcode(_Ask ask, CatalogFiles files) {
  while (true) {
    final code = ask.text(
      'Barcode (the digits under the bars; Enter if the bottle has none):',
    );
    if (code == null) return null;
    final cleaned = code.replaceAll(' ', '');
    if (gtinCheckDigitValid(cleaned) == false &&
        !ask.yesNo(
          '  The last digit does not match the others (check digit). '
          'Typo? Use it anyway?',
          defaultYes: false,
        )) {
      continue;
    }
    final users = files
        .records('barcodes.csv')
        .where((b) => b['code'] == cleaned)
        .map((b) => b['wine_id'])
        .toSet();
    if (users.isNotEmpty) {
      final names = files
          .records('wines.csv')
          .where((w) => users.contains(w['id']))
          .map((w) => '#${w['id']} ${w['name']}');
      ask.io.write('  → already used by: ${names.join(', ')}\n');
    }
    return cleaned;
  }
}

/// Finds [name] among [records] (by their 'name'): exact match after
/// normalization, else a close one confirmed by the user, else null (new).
Map<String, String>? _pickExisting(
  _Ask ask,
  String name,
  List<Map<String, String>> records,
  String what,
) {
  final wanted = normalizeForMatching(name);
  for (final r in records) {
    if (normalizeForMatching(r['name']!) == wanted) return r;
  }
  final ranked = [
    for (final r in records)
      (r, similarity(normalizeForMatching(r['name']!), wanted)),
  ]..sort((a, b) => b.$2.compareTo(a.$2));
  for (final (record, score) in ranked) {
    if (score < _similarNameThreshold) break;
    if (ask.yesNo(
      '  Did you mean $what "${record['name']}"?',
      defaultYes: true,
    )) {
      return record;
    }
  }
  return null;
}

/// GTIN-8/12/13/14 check digit. Null when [code] is not such a number
/// (internal codes are allowed, just not checkable).
bool? gtinCheckDigitValid(String code) {
  if (!RegExp(r'^\d+$').hasMatch(code) ||
      ![8, 12, 13, 14].contains(code.length)) {
    return null;
  }
  final digits = code.codeUnits.map((c) => c - 48).toList();
  final check = digits.removeLast();
  var sum = 0;
  for (var i = 0; i < digits.length; i++) {
    // Weights 3,1,3,1… starting from the digit left of the check digit.
    sum += digits[digits.length - 1 - i] * (i.isEven ? 3 : 1);
  }
  return (10 - sum % 10) % 10 == check;
}

class _Ask {
  _Ask(this.io);

  final Console io;

  String _line(String question) {
    io.write('$question ');
    final line = io.readLine();
    if (line == null) throw WizardAborted();
    return line.trim();
  }

  String? text(String question, {bool required = false}) {
    while (true) {
      final answer = _line(question);
      if (answer.isNotEmpty) return answer;
      if (!required) return null;
      io.write('  Required.\n');
    }
  }

  bool yesNo(String question, {required bool defaultYes}) {
    while (true) {
      final answer = _line('$question ${defaultYes ? '[Y/n]' : '[y/N]'}')
          .toLowerCase();
      if (answer.isEmpty) return defaultYes;
      if (answer == 'y' || answer == 'yes' || answer == 'da') return true;
      if (answer == 'n' || answer == 'no' || answer == 'nu') return false;
      io.write('  Answer y or n.\n');
    }
  }

  int? integer(String question, {int? min, int? max, int? defaultValue}) {
    while (true) {
      final answer = _line(
        defaultValue == null ? question : '$question [$defaultValue]',
      );
      if (answer.isEmpty && defaultValue != null) return defaultValue;
      final value = int.tryParse(answer);
      if (value != null &&
          (min == null || value >= min) &&
          (max == null || value <= max)) {
        return value;
      }
      io.write(
        '  Enter a whole number${min != null && max != null ? ' between $min and $max' : ''}.\n',
      );
    }
  }

  /// Returned as typed with a decimal point, e.g. "13.5"; null if skipped.
  String? decimal(String question, {double? max}) {
    while (true) {
      final answer = _line(question).replaceAll(',', '.');
      if (answer.isEmpty) return null;
      final value = double.tryParse(answer);
      if (value != null && value >= 0 && (max == null || value <= max)) {
        return answer;
      }
      io.write('  Enter a number (or press Enter to skip).\n');
    }
  }

  T choice<T>(String question, List<(String, T)> options) {
    io.write('$question\n');
    for (var i = 0; i < options.length; i++) {
      io.write('  ${i + 1}) ${options[i].$1}\n');
    }
    while (true) {
      final answer = _line('Choose 1–${options.length}:');
      final index = int.tryParse(answer);
      if (index != null && index >= 1 && index <= options.length) {
        return options[index - 1].$2;
      }
      final byName = options.where((o) => o.$1 == answer.toLowerCase());
      if (byName.isNotEmpty) return byName.first.$2;
    }
  }

  List<String> list(String question) => [
    for (final item in (text(question) ?? '').split(','))
      if (item.trim().isNotEmpty) item.trim(),
  ];

  List<String> lines(String question) {
    io.write('$question\n');
    final result = <String>[];
    while (true) {
      final line = _line('  >');
      if (line.isEmpty) return result;
      result.add(line);
    }
  }
}
