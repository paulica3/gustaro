// Developer test screen for trying real bottles. Not the product UI: it
// will be replaced by the real design, so its strings are deliberately not
// localized.
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../gustaro_core.dart';
import '../src/scan/label_matcher.dart';
import 'app_databases.dart';

/// Linear barcodes only, so a QR code on the label is not picked up first.
const _barcodeFormats = [
  BarcodeFormat.ean13,
  BarcodeFormat.ean8,
  BarcodeFormat.upcA,
  BarcodeFormat.upcE,
  BarcodeFormat.code128,
  BarcodeFormat.code39,
  BarcodeFormat.code93,
  BarcodeFormat.itf14,
  BarcodeFormat.codabar,
];

/// When to suggest the label instead. To be tuned on real bottles.
const _labelHintAfter = Duration(seconds: 5);

class ScanTestScreen extends StatefulWidget {
  const ScanTestScreen({super.key, required this.databases});

  final AppDatabases databases;

  @override
  State<ScanTestScreen> createState() => _ScanTestScreenState();
}

class _ScanTestScreenState extends State<ScanTestScreen> {
  late final _catalog = CatalogRepository(widget.databases.catalog);
  late final _scanner = ScanService(_catalog);
  late final _recent = RecentScansStore(widget.databases.user);
  late final Future<String> _catalogInfo = _loadCatalogInfo();
  final _camera = MobileScannerController(formats: _barcodeFormats);
  final _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  final _picker = ImagePicker();
  Future<LabelMatcher>? _debugMatcher;

  bool _scanning = true;
  DateTime _scanStarted = DateTime.now();
  Timer? _ticker;
  bool _busy = false;

  /// What was read: a barcode value or the OCR text.
  String? _inputTitle;
  String? _rawInput;

  /// Best label scores, including those below the threshold.
  List<String> _labelScores = const [];
  String? _error;

  /// Screens visited for the current scan; the last one is shown.
  final List<ScanOutcome> _path = [];
  final Map<int, Future<VintageDetails?>> _details = {};

  @override
  void initState() {
    super.initState();
    _startTicker();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _camera.dispose();
    _textRecognizer.close();
    super.dispose();
  }

  Future<String> _loadCatalogInfo() async {
    final meta = await _catalog.meta();
    final wines = (await _catalog.labelIndex()).length;
    return 'Catalogue v${meta?.dataVersion} · $wines wines';
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(milliseconds: 200), (_) {
      if (mounted) setState(() {});
    });
  }

  Future<void> _rescan() async {
    setState(() {
      _clearResult();
      _scanning = true;
      _scanStarted = DateTime.now();
    });
    _startTicker();
    await _camera.start();
  }

  Future<void> _pauseCamera() async {
    _ticker?.cancel();
    setState(() => _scanning = false);
    await _camera.stop();
  }

  void _clearResult() {
    _inputTitle = null;
    _rawInput = null;
    _labelScores = const [];
    _error = null;
    _path.clear();
    _details.clear();
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (!_scanning) return;
    final barcode = capture.barcodes
        .where((b) => b.rawValue != null)
        .firstOrNull;
    if (barcode == null) return;
    final elapsed = DateTime.now().difference(_scanStarted);
    await _pauseCamera();
    await _resolveBarcode(
      barcode,
      'Barcode (camera, found after ${_seconds(elapsed)})',
    );
  }

  Future<void> _barcodeFromPhoto() => _run(() async {
    await _pauseCamera();
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final capture = await _camera.analyzeImage(
      image.path,
      formats: _barcodeFormats,
    );
    final barcode = capture?.barcodes
        .where((b) => b.rawValue != null)
        .firstOrNull;
    if (barcode == null) {
      setState(() {
        _clearResult();
        _error = 'No barcode found in that photo.';
      });
      return;
    }
    await _resolveBarcode(barcode, 'Barcode (photo)');
  });

  Future<void> _resolveBarcode(Barcode barcode, String title) => _run(() async {
    final outcome = await _scanner.resolveBarcode(barcode.rawValue!);
    setState(() {
      _clearResult();
      _inputTitle = '$title · ${barcode.format.name}';
      _rawInput = barcode.rawValue;
      _path.add(outcome);
    });
  });

  Future<void> _readLabel(ImageSource source) => _run(() async {
    // The system camera cannot open while the scanner holds the camera.
    await _pauseCamera();
    final image = await _picker.pickImage(source: source);
    if (image == null) return;
    final recognized = await _textRecognizer.processImage(
      InputImage.fromFilePath(image.path),
    );
    final text = recognized.text;
    final outcome = await _scanner.resolveLabel(text);
    final matcher = await (_debugMatcher ??= _catalog.labelIndex().then(
      (index) => LabelMatcher(
        index,
        config: const LabelMatchConfig(threshold: 0, maxCandidates: 5),
      ),
    ));
    setState(() {
      _clearResult();
      _inputTitle =
          'Label text (${source == ImageSource.camera ? 'camera' : 'photo'})';
      _rawInput = text.isEmpty ? '(no text recognized)' : text;
      _labelScores = [
        for (final m in matcher.match(text))
          '${m.score.toStringAsFixed(2)}  ${m.entry.wine.wineryName} · '
              '${m.entry.wine.name}',
      ];
      _path.add(outcome);
    });
  });

  Future<void> _run(Future<void> Function() action) async {
    setState(() => _busy = true);
    try {
      await action();
    } catch (e) {
      setState(() => _error = '$e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _go(ScanOutcome next) => setState(() => _path.add(next));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gustaro · scan test'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: FutureBuilder(
            future: _catalogInfo,
            builder: (context, snap) => Text(
              snap.data ?? (snap.hasError ? '${snap.error}' : '…'),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 240, child: _cameraBox()),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Wrap(
              spacing: 8,
              runSpacing: 4,
              alignment: WrapAlignment.center,
              children: [
                if (!_scanning)
                  FilledButton.icon(
                    onPressed: _busy ? null : _rescan,
                    icon: const Icon(Icons.qr_code_scanner),
                    label: const Text('Scan barcode'),
                  ),
                OutlinedButton.icon(
                  onPressed: _busy
                      ? null
                      : () => _readLabel(ImageSource.camera),
                  icon: const Icon(Icons.photo_camera),
                  label: const Text('Label: take photo'),
                ),
                OutlinedButton.icon(
                  onPressed: _busy
                      ? null
                      : () => _readLabel(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Label: from photos'),
                ),
                OutlinedButton.icon(
                  onPressed: _busy ? null : _barcodeFromPhoto,
                  icon: const Icon(Icons.image_search),
                  label: const Text('Barcode: from photos'),
                ),
              ],
            ),
          ),
          if (_busy) const LinearProgressIndicator(),
          Expanded(child: _resultList()),
        ],
      ),
    );
  }

  Widget _cameraBox() {
    final elapsed = DateTime.now().difference(_scanStarted);
    return Stack(
      fit: StackFit.expand,
      children: [
        MobileScanner(controller: _camera, onDetect: _onDetect),
        if (!_scanning)
          const ColoredBox(
            color: Colors.black87,
            child: Center(
              child: Text(
                'Camera paused',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        if (_scanning)
          Positioned(
            left: 8,
            bottom: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.all(6),
              color: Colors.black54,
              child: Text(
                elapsed >= _labelHintAfter
                    ? 'No barcode after ${_seconds(elapsed)} — try the label'
                    : 'Looking for a barcode… ${_seconds(elapsed)}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }

  Widget _resultList() {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        if (_error != null)
          Text(_error!, style: TextStyle(color: theme.colorScheme.error)),
        if (_rawInput != null) ...[
          Row(
            children: [
              Expanded(
                child: Text(_inputTitle!, style: theme.textTheme.titleSmall),
              ),
              IconButton(
                tooltip: 'Copy',
                icon: const Icon(Icons.copy, size: 18),
                onPressed: () =>
                    Clipboard.setData(ClipboardData(text: _rawInput!)),
              ),
            ],
          ),
          SelectableText(_rawInput!, style: theme.textTheme.bodyLarge),
          const Divider(),
        ],
        if (_labelScores.isNotEmpty) ...[
          Text(
            'Label scores (threshold '
            '${_scanner.labelConfig.threshold})',
            style: theme.textTheme.titleSmall,
          ),
          for (final line in _labelScores)
            Text(line, style: const TextStyle(fontFamily: 'Courier')),
          const Divider(),
        ],
        if (_path.isNotEmpty) ...[
          if (_path.length > 1)
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () => setState(_path.removeLast),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back'),
              ),
            ),
          _outcomeView(_path.last),
        ],
      ],
    );
  }

  Widget _outcomeView(ScanOutcome outcome) {
    final theme = Theme.of(context);
    Widget heading(String text) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: theme.textTheme.titleMedium),
    );

    switch (outcome) {
      case ShowVintage(:final vintageId):
        return FutureBuilder(
          future: _details.putIfAbsent(vintageId, () async {
            final details = await _catalog.vintageDetails(vintageId);
            await _recent.record(vintageId);
            return details;
          }),
          builder: (context, snap) {
            final d = snap.data;
            if (d == null) {
              return Text(snap.hasError ? '${snap.error}' : 'Loading…');
            }
            return _detailsView(d);
          },
        );

      case ChooseVintage(
        :final wine,
        :final vintages,
        :final preselectedVintageId,
      ):
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heading(
              'Screen: pick the year — ${wine.wineryName} · ${wine.name}',
            ),
            Wrap(
              spacing: 8,
              children: [
                for (final v in vintages)
                  v.id == preselectedVintageId
                      ? FilledButton(
                          onPressed: () => _go(ShowVintage(v.id)),
                          child: Text('${v.year} (read on label)'),
                        )
                      : OutlinedButton(
                          onPressed: () => _go(ShowVintage(v.id)),
                          child: Text('${v.year}'),
                        ),
              ],
            ),
          ],
        );

      case ChooseWine(:final source, :final candidates):
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heading(
              source == ScanSource.barcode
                  ? 'Screen: several wines share this barcode'
                  : 'Screen: is it one of these?',
            ),
            for (final c in candidates)
              Card(
                child: ListTile(
                  title: Text(c.wine.name),
                  subtitle: Text(c.wine.wineryName),
                  trailing: c.score == null
                      ? null
                      : Text(c.score!.toStringAsFixed(2)),
                  onTap: () => _go(c.next),
                ),
              ),
          ],
        );

      case NotInCatalogue(:final canTryLabel):
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heading('Screen: not in our catalogue yet'),
            if (canTryLabel)
              OutlinedButton.icon(
                onPressed: _busy ? null : () => _readLabel(ImageSource.camera),
                icon: const Icon(Icons.photo_camera),
                label: const Text('Try the label instead'),
              ),
          ],
        );
    }
  }

  Widget _detailsView(VintageDetails d) {
    final theme = Theme.of(context);
    String num(double? value, String unit) =>
        value == null ? '—' : '$value $unit';
    final rows = <(String, String)>[
      ('Winery', d.wine.wineryName),
      ('Region', d.region ?? '—'),
      ('Type', d.wine.type.name),
      ('Grapes', d.grapeVarieties.isEmpty ? '—' : d.grapeVarieties.join(', ')),
      ('Alcohol', num(d.abv, '%')),
      ('Acidity', num(d.acidityGL, 'g/L')),
      ('Tannins', num(d.tanninsGL, 'g/L')),
      ('Residual sugar', num(d.residualSugarGL, 'g/L')),
      ('Description', d.description ?? '—'),
      ('Sensory notes', d.sensoryNotes ?? '—'),
      ('Pairings', d.foodPairings.isEmpty ? '—' : d.foodPairings.join(', ')),
      ('Text language', d.language),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Screen: result — ${d.wine.name} ${d.year}',
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        for (final (label, value) in rows)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 120,
                  child: Text(label, style: theme.textTheme.bodySmall),
                ),
                Expanded(child: Text(value)),
              ],
            ),
          ),
      ],
    );
  }
}

String _seconds(Duration d) =>
    '${(d.inMilliseconds / 1000).toStringAsFixed(1)} s';
