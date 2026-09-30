import 'package:flutter/material.dart';

import 'app/app_databases.dart';
import 'app/scan_test_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const GustaroApp());
}

class GustaroApp extends StatefulWidget {
  const GustaroApp({super.key});

  @override
  State<GustaroApp> createState() => _GustaroAppState();
}

class _GustaroAppState extends State<GustaroApp> {
  final Future<AppDatabases> _databases = AppDatabases.open();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gustaro',
      theme: ThemeData(colorSchemeSeed: const Color(0xFFD22B3B)),
      home: FutureBuilder(
        future: _databases,
        builder: (context, snap) {
          if (snap.hasData) return ScanTestScreen(databases: snap.data!);
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: snap.hasError
                    ? Text('Could not open the catalogue:\n${snap.error}')
                    : const CircularProgressIndicator(),
              ),
            ),
          );
        },
      ),
    );
  }
}
