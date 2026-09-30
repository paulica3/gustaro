import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../gustaro_core.dart';

const _catalogAsset = 'assets/catalog.sqlite';

/// The two databases the app uses: the bundled catalogue (replaced on
/// every launch from the app bundle) and on-device user data.
final class AppDatabases {
  AppDatabases._(this.catalog, this.user);

  final CatalogDatabase catalog;
  final UserDatabase user;

  /// Copies the bundled catalogue out of the app bundle (SQLite cannot open
  /// a file inside it) and opens both databases. Throws if the catalogue
  /// was built for another schema version: better to fail than to show
  /// wrong data.
  static Future<AppDatabases> open() async {
    final dir = await getApplicationSupportDirectory();
    await dir.create(recursive: true);

    final catalogFile = File('${dir.path}/catalog.sqlite');
    final bytes = await rootBundle.load(_catalogAsset);
    await catalogFile.writeAsBytes(
      bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes),
      flush: true,
    );

    final catalog = CatalogDatabase(NativeDatabase(catalogFile));
    final meta = await CatalogRepository(catalog).meta();
    if (meta?.schemaVersion != CatalogDatabase.currentSchemaVersion) {
      await catalog.close();
      throw StateError(
        'Bundled catalogue has schema ${meta?.schemaVersion}, '
        'app expects ${CatalogDatabase.currentSchemaVersion}. '
        'Rebuild it with tool/build_catalog.dart.',
      );
    }

    final user = UserDatabase(NativeDatabase(File('${dir.path}/user.sqlite')));
    return AppDatabases._(catalog, user);
  }
}
