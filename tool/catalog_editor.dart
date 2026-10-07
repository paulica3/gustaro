// Local web editor for the wine catalogue.
//
//   dart run tool/catalog_editor.dart [--data data] [--out assets/catalog.sqlite] [--port 8787]
//
// Opens http://localhost:8787 in your browser. Ctrl+C to stop.
import 'dart:io';

import 'src/editor_server.dart';

Future<void> main(List<String> args) async {
  final options = <String, String>{
    for (var i = 0; i + 1 < args.length; i += 2) args[i]: args[i + 1],
  };
  final html = File.fromUri(Platform.script.resolve('editor/index.html'));
  final server = await startEditorServer(
    dataDir: options['--data'] ?? 'data',
    outPath: options['--out'] ?? 'assets/catalog.sqlite',
    htmlFile: html.existsSync() ? html : File('tool/editor/index.html'),
    port: int.parse(options['--port'] ?? '8787'),
  );
  final url = 'http://localhost:${server.port}';
  stdout.writeln('Catalogue editor running at $url  (Ctrl+C to stop)');
  if (Platform.isMacOS) await Process.run('open', [url]);
}
