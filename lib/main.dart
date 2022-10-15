import 'package:dart_ice_and_fire/iceAndFireNav.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import 'services/iceFireAPI.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.instance.registerSingleton<IceFireApi>(IceFireApi());
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ice & Fire',
      debugShowCheckedModeBanner: false,
      theme: FlexThemeData.light(
          scheme: FlexScheme.deepBlue,
          appBarStyle: FlexAppBarStyle.primary,
          useMaterial3: true),
      darkTheme:
          FlexThemeData.dark(scheme: FlexScheme.deepBlue, useMaterial3: true),
      themeMode: ThemeMode.dark,
      home: const IceAndFireNav(),
    );
  }
}
