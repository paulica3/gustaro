import 'dart:math' as math;

import '../catalog/models.dart';
import 'text_normalizer.dart';

/// Tuning knobs for label matching. Defaults are a starting point, to be
/// adjusted against the real bottle set.
final class LabelMatchConfig {
  const LabelMatchConfig({
    this.threshold = 0.75,
    this.maxCandidates = 3,
    this.wineryWeight = 0.5,
    this.minTokenLength = 3,
  });

  /// Minimum combined score (0..1) for a wine to be offered at all.
  final double threshold;

  /// How many candidates the user is shown at most.
  final int maxCandidates;

  /// Share of the score coming from the winery name; the rest comes from
  /// the wine name.
  final double wineryWeight;

  /// Name words shorter than this ("de", "la") are ignored, unless a name
  /// consists only of such words.
  final int minTokenLength;
}

final class LabelMatch {
  const LabelMatch(this.entry, this.score);

  final LabelIndexEntry entry;

  /// 0..1, higher is better.
  final double score;
}

/// Fuzzy-matches OCR text against winery and wine names. Build once per
/// catalogue: the index is normalized in the constructor.
class LabelMatcher {
  LabelMatcher(
    List<LabelIndexEntry> index, {
    this.config = const LabelMatchConfig(),
  }) : _entries = [
         for (final entry in index)
           (
             entry: entry,
             winery: _nameTokens(entry.wine.wineryName, config.minTokenLength),
             wine: _nameTokens(entry.wine.name, config.minTokenLength),
           ),
       ];

  final LabelMatchConfig config;
  final List<({LabelIndexEntry entry, List<String> winery, List<String> wine})>
  _entries;

  /// Wines scoring at least [LabelMatchConfig.threshold], best first, at
  /// most [LabelMatchConfig.maxCandidates].
  List<LabelMatch> match(String ocrText) {
    final labelWords = _labelWords(tokenize(ocrText));
    if (labelWords.isEmpty) return const [];

    final matches = <LabelMatch>[];
    for (final e in _entries) {
      final score =
          config.wineryWeight * _phraseScore(e.winery, labelWords) +
          (1 - config.wineryWeight) * _phraseScore(e.wine, labelWords);
      if (score >= config.threshold) matches.add(LabelMatch(e.entry, score));
    }
    // Stable tie-break on wine id keeps results deterministic.
    matches.sort((a, b) {
      final byScore = b.score.compareTo(a.score);
      return byScore != 0
          ? byScore
          : a.entry.wine.id.compareTo(b.entry.wine.id);
    });
    return matches.take(config.maxCandidates).toList();
  }

  static List<String> _nameTokens(String name, int minLength) {
    final tokens = tokenize(name);
    final long = tokens.where((t) => t.length >= minLength).toList();
    return long.isEmpty ? tokens : long;
  }

  /// Label words plus each pair of adjacent words joined, so a name that
  /// OCR split in two ("Pur cari") still matches.
  static Set<String> _labelWords(List<String> tokens) => {
    ...tokens,
    for (var i = 0; i + 1 < tokens.length; i++) tokens[i] + tokens[i + 1],
  };

  /// Average, over the name's words, of the best similarity to any label word.
  static double _phraseScore(List<String> nameTokens, Set<String> labelWords) {
    if (nameTokens.isEmpty) return 0;
    var total = 0.0;
    for (final token in nameTokens) {
      var best = 0.0;
      for (final word in labelWords) {
        best = math.max(best, similarity(token, word));
        if (best == 1) break;
      }
      total += best;
    }
    return total / nameTokens.length;
  }
}

/// 1 - (Levenshtein distance / length of the longer string), in 0..1.
double similarity(String a, String b) {
  if (a == b) return 1;
  final longest = math.max(a.length, b.length);
  if (longest == 0) return 1;
  return 1 - levenshtein(a, b) / longest;
}

int levenshtein(String a, String b) {
  if (a.isEmpty) return b.length;
  if (b.isEmpty) return a.length;
  var previous = List<int>.generate(b.length + 1, (i) => i);
  var current = List<int>.filled(b.length + 1, 0);
  for (var i = 1; i <= a.length; i++) {
    current[0] = i;
    for (var j = 1; j <= b.length; j++) {
      final cost = a.codeUnitAt(i - 1) == b.codeUnitAt(j - 1) ? 0 : 1;
      current[j] = math.min(
        math.min(current[j - 1] + 1, previous[j] + 1),
        previous[j - 1] + cost,
      );
    }
    final swap = previous;
    previous = current;
    current = swap;
  }
  return previous[b.length];
}

final RegExp _yearPattern = RegExp(r'(?<!\d)(19|20)\d{2}(?!\d)');

/// Four-digit 19xx/20xx numbers standing on their own in [text].
Set<int> extractYears(String text) => {
  for (final m in _yearPattern.allMatches(text)) int.parse(m.group(0)!),
};
