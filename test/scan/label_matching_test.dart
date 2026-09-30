import 'package:flutter_test/flutter_test.dart';
import 'package:gustaro/src/catalog/models.dart';
import 'package:gustaro/src/scan/label_matcher.dart';
import 'package:gustaro/src/scan/text_normalizer.dart';

LabelIndexEntry _entry(int id, String winery, String name) => LabelIndexEntry(
  wine: WineSummary(id: id, name: name, wineryName: winery, type: WineType.red),
  vintages: [VintageOption(id: id * 10, year: 2020)],
);

void main() {
  group('normalizeForMatching', () {
    test('strips Romanian diacritics: ă â î ș ț', () {
      expect(normalizeForMatching('ă â î ș ț'), 'a a i s t');
      expect(normalizeForMatching('Ă Â Î Ș Ț'), 'a a i s t');
    });

    test('treats legacy cedilla ş ţ like comma-below ș ț', () {
      expect(
        normalizeForMatching('Fetească Ţărăncuţa ş'),
        'feteasca tarancuta s',
      );
    });

    test('handles decomposed input (base letter + combining mark)', () {
      expect(normalizeForMatching('Fetea\u0306sca\u0306'), 'feteasca');
    });

    test('strips other Latin diacritics found in winery names', () {
      expect(
        normalizeForMatching('Château Gewürztraminer'),
        'chateau gewurztraminer',
      );
    });

    test('collapses punctuation and whitespace, keeps digits', () {
      expect(
        normalizeForMatching('  Rară-Neagră,\n2019 (13,5%)  '),
        'rara neagra 2019 13 5',
      );
    });

    test('keeps Cyrillic letters instead of dropping them', () {
      expect(normalizeForMatching('Фетяска Нягрэ'), 'фетяска нягрэ');
    });

    test('tokenize splits normalized words; empty input gives none', () {
      expect(tokenize('Crama Țărăncuța'), ['crama', 'tarancuta']);
      expect(tokenize(' -- '), isEmpty);
    });
  });

  group('similarity', () {
    test('identical strings are 1, completely different are 0', () {
      expect(similarity('purcari', 'purcari'), 1);
      expect(similarity('abc', 'xyz'), 0);
    });

    test('one OCR misread letter stays high', () {
      // "l" read instead of "i": 1 edit over 7 letters.
      expect(similarity('purcari', 'purcarl'), closeTo(6 / 7, 1e-9));
    });

    test('levenshtein counts insertions, deletions and substitutions', () {
      expect(levenshtein('kitten', 'sitting'), 3);
      expect(levenshtein('', 'abc'), 3);
    });
  });

  group('extractYears', () {
    test('finds standalone 19xx and 20xx numbers only', () {
      expect(extractYears('Recolta 2019, fondat 1827, lot 120195, 750 ml'), {
        2019,
      });
      expect(extractYears('Vintage 1998 / 2003'), {1998, 2003});
      expect(extractYears('Cod 48412019'), isEmpty);
    });
  });

  group('LabelMatcher', () {
    final matcher = LabelMatcher([
      _entry(1, 'Crama Țărăncuța', 'Fetească Neagră'),
      _entry(2, 'Crama Țărăncuța', 'Rară Neagră'),
      _entry(3, 'Castel Mireștii', 'Fetească Neagră'),
      _entry(4, 'Château Vălenii', 'Fetească Albă'),
    ]);

    test('exact label ranks the right wine first with score 1', () {
      final matches = matcher.match('Crama Țărăncuța Fetească Neagră');
      expect(matches.first.entry.wine.id, 1);
      expect(matches.first.score, 1);
    });

    test('matches without diacritics and in any case', () {
      final matches = matcher.match('CRAMA TARANCUTA FETEASCA NEAGRA');
      expect(matches.first.entry.wine.id, 1);
      expect(matches.first.score, 1);
    });

    test('tolerates OCR misreads', () {
      final matches = matcher.match('Crama Tarancuta Fetcasca Neagra');
      expect(matches.first.entry.wine.id, 1);
      expect(matches.first.score, greaterThan(0.9));
    });

    test('tolerates a name split in two by OCR', () {
      final matches = matcher.match('Crama Taran cuta Feteasca Neagra');
      expect(matches.first.entry.wine.id, 1);
      expect(matches.first.score, 1);
    });

    test('same grape from another winery is below threshold', () {
      final matches = matcher.match('Crama Țărăncuța Fetească Neagră');
      expect(matches.map((m) => m.entry.wine.id), isNot(contains(3)));
    });

    test('same winery, similar wine name is offered as a lower candidate', () {
      final matches = matcher.match('Crama Țărăncuța Rară Neagră');
      expect(matches.first.entry.wine.id, 2);
      expect(matches.map((m) => m.entry.wine.id), contains(1));
      expect(matches[0].score, greaterThan(matches[1].score));
    });

    test('unrelated text matches nothing', () {
      expect(matcher.match('Lorem ipsum dolor sit amet'), isEmpty);
    });

    test('respects maxCandidates', () {
      final strict = LabelMatcher([
        for (var i = 0; i < 6; i++)
          _entry(i, 'Crama Țărăncuța', 'Fetească Neagră'),
      ], config: const LabelMatchConfig(maxCandidates: 2));
      expect(strict.match('Crama Țărăncuța Fetească Neagră').length, 2);
    });
  });
}
