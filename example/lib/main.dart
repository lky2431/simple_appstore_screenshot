import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:simple_appstore_screenshot/simple_appstore_screenshot.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final bool isCupertino = false;

  @override
  Widget build(BuildContext context) {
    if (isCupertino) {
      return const CupertinoApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en'), // English
            Locale('es'), // Spanish
          ],
          debugShowCheckedModeBanner: false,
          home: CupertinoPage(
            title: "Demo Page",
          ));
    }

    return MaterialApp(
      title: 'Simple AppStore Demo',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('es'), // Spanish
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MaterialPage(title: 'Demo Page'),
    );
  }
}

class CupertinoPage extends StatelessWidget {
  const CupertinoPage({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return SimpleScreenShot(
      callback: (Uint8List? image) async {
        if (image != null) {
          //do something to this image
        }
      },
      description: (context) => const Text(
        "This is description",
        style: TextStyle(fontSize: 16),
      ),
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          middle: Text(title),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'This is simple appstore screenshot cupertino demo',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MaterialPage extends StatelessWidget {
  const MaterialPage({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return SimpleScreenShot(
      callback: (Uint8List? image) async {
        if (image != null) {
          //do something to this image
        }
      },
      description: (context) => const Text(
        "This is description",
        style: TextStyle(fontSize: 16),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'This is simple appstore screenshot material demo',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
