/// Everything the UI needs from the logic layer. Pure Dart: no Flutter
/// imports, so the data build script can reuse the same code.
library;

export 'src/catalog/catalog_database.dart' show CatalogDatabase;
export 'src/catalog/catalog_repository.dart';
export 'src/catalog/models.dart';
export 'src/recent/recent_scans.dart'
    show RecentScan, RecentScansStore, UserDatabase;
export 'src/scan/label_matcher.dart' show LabelMatchConfig;
export 'src/scan/scan_outcome.dart';
export 'src/scan/scan_service.dart';
