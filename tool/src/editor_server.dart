import 'dart:convert';
import 'dart:io';

import 'build_catalog_file.dart';
import 'catalog_builder.dart';
import 'catalog_files.dart';

/// Requests larger than this are refused (the whole catalogue is sent on
/// every save; a few thousand wines are well under 1 MB).
const _maxBodyBytes = 10 * 1024 * 1024;

/// Local catalogue editor: serves the page and a small JSON API over the
/// CSV files in [dataDir]. Listens on 127.0.0.1 only.
///
/// - GET  /              the editor page ([htmlFile])
/// - GET  /api/catalog   all tables, a version, validation errors/warnings
/// - POST /api/save      replace all tables; validated, saved, catalogue rebuilt
Future<HttpServer> startEditorServer({
  required String dataDir,
  required String outPath,
  required File htmlFile,
  int port = 8787,
}) async {
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, port);
  server.listen((request) async {
    try {
      await _handle(request, server.port, dataDir, outPath, htmlFile);
    } catch (e, stack) {
      stderr.writeln('editor error: $e\n$stack');
      await _json(request.response, 500, {
        'error': 'Internal error, see terminal.',
      });
    }
  });
  return server;
}

Future<void> _handle(
  HttpRequest request,
  int port,
  String dataDir,
  String outPath,
  File htmlFile,
) async {
  final response = request.response;

  // Only this machine's browser, addressing us by a local name: blocks DNS
  // rebinding, where a website points its own domain at 127.0.0.1.
  final host = request.headers.host;
  if (host != 'localhost' && host != '127.0.0.1') {
    return _json(response, 403, {'error': 'Forbidden host.'});
  }
  // Writes only from our own page. Requiring JSON also forces browsers to
  // ask permission (CORS preflight) before another site could post, which
  // this server never grants.
  if (request.method == 'POST') {
    final origin = request.headers.value('origin');
    final allowed = {'http://localhost:$port', 'http://127.0.0.1:$port'};
    if (origin != null && !allowed.contains(origin)) {
      return _json(response, 403, {'error': 'Forbidden origin.'});
    }
    if (request.headers.contentType?.mimeType != 'application/json') {
      return _json(response, 415, {'error': 'Expected JSON.'});
    }
  }

  switch ((request.method, request.uri.path)) {
    case ('GET', '/'):
      response.headers
        ..contentType = ContentType.html
        ..set('Cache-Control', 'no-store');
      response.write(await htmlFile.readAsString());
      await response.close();
    case ('GET', '/api/catalog'):
      await _json(response, 200, _catalogPayload(CatalogFiles.load(dataDir)));
    case ('POST', '/api/save'):
      await _save(request, dataDir, outPath);
    default:
      await _json(response, 404, {'error': 'Not found.'});
  }
}

Future<void> _save(HttpRequest request, String dataDir, String outPath) async {
  final response = request.response;
  final Object? body;
  try {
    body = jsonDecode(await _readBody(request));
  } on FormatException {
    return _json(response, 400, {'error': 'Invalid request.'});
  }
  if (body is! Map<String, dynamic> ||
      body['version'] is! String ||
      body['tables'] is! Map<String, dynamic>) {
    return _json(response, 400, {'error': 'Invalid request.'});
  }

  final current = CatalogFiles.load(dataDir);
  if (body['version'] != _version(current)) {
    return _json(response, 409, {
      'error':
          'The files changed outside the editor (e.g. in Excel). '
          'Reload the page; your last change was not saved.',
    });
  }

  // Rebuild every table from the posted records, keeping each file's own
  // header (and any extra columns).
  final tables = body['tables'] as Map<String, dynamic>;
  final updated = <String, CsvTable>{};
  for (final MapEntry(key: name, value: table) in current.tables.entries) {
    final records = tables[name];
    if (records is! List) {
      return _json(response, 400, {'error': 'Missing table $name.'});
    }
    final next = CsvTable(table.header, []);
    for (final record in records) {
      if (record is! Map<String, dynamic> ||
          record.values.any((v) => v is! String)) {
        return _json(response, 400, {'error': 'Invalid row in $name.'});
      }
      try {
        next.add(record.cast<String, String>());
      } on ArgumentError {
        return _json(response, 400, {'error': 'Unknown column in $name.'});
      }
    }
    updated[name] = next;
  }

  final files = CatalogFiles(updated);
  final build = validateCatalog(files.toCsvStrings());
  if (!build.isValid) {
    return _json(response, 422, {'errors': build.errors});
  }
  files.save(dataDir);
  if (!await buildCatalogFile(dataDir, outPath)) {
    return _json(response, 500, {
      'error': 'Saved, but rebuilding failed; see terminal.',
    });
  }
  await _json(response, 200, _catalogPayload(CatalogFiles.load(dataDir)));
}

Map<String, Object> _catalogPayload(CatalogFiles files) {
  final build = validateCatalog(files.toCsvStrings());
  return {
    'version': _version(files),
    'tables': {
      for (final MapEntry(key: name, value: table) in files.tables.entries)
        name: table.records,
    },
    'errors': build.errors,
    'warnings': build.warnings,
  };
}

/// Fingerprint of the files' content (FNV-1a), to detect edits made
/// outside the editor between loading the page and saving.
String _version(CatalogFiles files) {
  var hash = 0x811c9dc5;
  for (final content in files.toCsvStrings().values) {
    for (final unit in content.codeUnits) {
      hash = ((hash ^ unit) * 0x01000193) & 0xffffffff;
    }
  }
  return hash.toRadixString(16);
}

Future<String> _readBody(HttpRequest request) async {
  final bytes = <int>[];
  await for (final chunk in request) {
    bytes.addAll(chunk);
    if (bytes.length > _maxBodyBytes) throw const FormatException('too large');
  }
  return utf8.decode(bytes);
}

Future<void> _json(HttpResponse response, int status, Object body) async {
  response
    ..statusCode = status
    ..headers.contentType = ContentType.json
    ..headers.set('Cache-Control', 'no-store')
    ..write(jsonEncode(body));
  await response.close();
}
