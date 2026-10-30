import 'package:dart_ice_and_fire/iceAndFireNav.dart';
import 'package:dart_ice_and_fire/iceTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ice & Fire',
      debugShowCheckedModeBanner: false,
      theme: iceTheme,
      home: const IceAndFireNav(),
    );
  }
}
