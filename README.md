# Gustaro

Scan a Moldovan wine bottle and see verified, winemaker-supplied information:
technical specifications, sensory notes and food pairings. Offline, no
accounts, no ratings.

Status: prototype. Scan and resolution logic, data model, CSV build script and
a developer **scan test screen** (camera barcode scan, label OCR, raw values
shown) are done. The real UI comes later and reuses the same logic.

## Setup

- Flutter stable (developed with 3.47 / Dart 3.13): `brew install --cask flutter`
- iOS builds: Xcode + CocoaPods (`brew install cocoapods`). Minimum iOS 15.5
  (ML Kit). ML Kit does not run on the iOS Simulator on Apple Silicon: test on
  a real iPhone.
- Android: Android Studio + SDK (not set up yet).

```bash
flutter pub get
```

## Run on your iPhone

One-time setup:
1. `open ios/Runner.xcworkspace`, select **Runner** → **Signing & Capabilities**,
   choose your Apple ID team (add it under Xcode → Settings → Accounts). If
   Xcode says the bundle ID is taken, change `com.gustaro.gustaro` to
   something unique.
2. On the iPhone: Settings → Privacy & Security → **Developer Mode** on.
3. Connect the iPhone by cable and trust the Mac.

Then:

```bash
flutter run --release
```

`--release` keeps the app working after unplugging. On first launch you may
need to trust the developer: Settings → General → VPN & Device Management.
With a free Apple ID the install expires after 7 days; run it again.

## Try real bottles

1. Scan a bottle. The screen shows the barcode value and type (copy button),
   how long detection took, and which screen the app would show.
2. For the label: "Label: take photo" (or pick a photo). It shows the text ML
   Kit read and the best match scores, including those below the threshold.
3. Add the bottle with the wizard (it saves to `data/` and rebuilds the
   catalogue; see [docs/data-entry.md](docs/data-entry.md)), then reinstall:

```bash
dart run tool/add_bottle.dart
```

```bash
flutter run --release
```

## Run the tests

```bash
flutter test
```

## Regenerate drift code after changing a table

```bash
dart run build_runner build
```

Generated `*.g.dart` files are committed.

## Layout

```
lib/
  gustaro_core.dart          single import for the UI
  src/catalog/               drift schema, repository, domain models
  src/scan/                  normalizer, label matcher, pure resolution, ScanService
  src/recent/                on-device recent scans
  app/                       Flutter side: opening the DBs, scan test screen
tool/add_bottle.dart         add a bottle by answering questions
tool/build_catalog.dart      CSV → assets/catalog.sqlite
data/                        catalogue source CSVs
test/                        unit + in-memory DB + build script tests
docs/                        data model, resolution flow, decision log
```

## Wiring the UI (sketch)

```dart
import 'package:gustaro/gustaro_core.dart';

final catalog = CatalogRepository(catalogDb);
final scanner = ScanService(catalog);
final recent = RecentScansStore(userDb);

final outcome = await scanner.resolveBarcode(barcode.rawValue!);
// or: await scanner.resolveLabel(recognizedText.text);

switch (outcome) {
  case ShowVintage(:final vintageId):
    final details = await catalog.vintageDetails(vintageId, language: 'ro');
    await recent.record(vintageId);
  case ChooseVintage(:final wine, :final vintages, :final preselectedVintageId):
    // picker → ShowVintage(selected.id)
  case ChooseWine(:final candidates):
    // list → show candidate.next
  case NotInCatalogue(:final canTryLabel):
    // miss screen
}
```

See [docs/data-entry.md](docs/data-entry.md), [docs/resolution-flow.md](docs/resolution-flow.md),
[docs/data-model.md](docs/data-model.md) and
[docs/decisions.md](docs/decisions.md).
