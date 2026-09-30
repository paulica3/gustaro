/// Text normalization for matching OCR output against catalogue names.
library;

/// Latin letters with diacritics mapped to their base letter. Covers
/// Romanian in both the correct comma-below form (ș ț) and the legacy
/// cedilla form (ş ţ) that OCR and old fonts often produce, plus the
/// French/German letters common in winery names (Château, Gewürztraminer).
const Map<String, String> _baseLetters = {
  'ă': 'a',
  'â': 'a',
  'à': 'a',
  'á': 'a',
  'ä': 'a',
  'ã': 'a',
  'å': 'a',
  'î': 'i',
  'ì': 'i',
  'í': 'i',
  'ï': 'i',
  'ș': 's',
  'ş': 's',
  'š': 's',
  'ś': 's',
  'ț': 't',
  'ţ': 't',
  'ť': 't',
  'é': 'e',
  'è': 'e',
  'ê': 'e',
  'ë': 'e',
  'ó': 'o',
  'ò': 'o',
  'ô': 'o',
  'ö': 'o',
  'õ': 'o',
  'ú': 'u',
  'ù': 'u',
  'û': 'u',
  'ü': 'u',
  'ç': 'c',
  'č': 'c',
  'ć': 'c',
  'ñ': 'n',
  'ž': 'z',
  'ý': 'y',
  'ÿ': 'y',
};

// Unicode combining marks (U+0300–U+036F), in case text arrives decomposed.
final RegExp _combiningMarks = RegExp(r'[\u0300-\u036f]', unicode: true);
final RegExp _nonAlphanumeric = RegExp(r'[^\p{L}\p{N}]+', unicode: true);

/// Lowercases, strips diacritics and collapses everything that is not a
/// letter or digit into single spaces. Non-Latin letters (e.g. Cyrillic)
/// are lowercased and kept, not dropped.
String normalizeForMatching(String input) {
  final lower = input.toLowerCase().replaceAll(_combiningMarks, '');
  final buffer = StringBuffer();
  for (final rune in lower.runes) {
    final char = String.fromCharCode(rune);
    buffer.write(_baseLetters[char] ?? char);
  }
  return buffer.toString().replaceAll(_nonAlphanumeric, ' ').trim();
}

/// [normalizeForMatching] split into words.
List<String> tokenize(String input) {
  final normalized = normalizeForMatching(input);
  return normalized.isEmpty ? const [] : normalized.split(' ');
}
