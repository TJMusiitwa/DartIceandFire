import 'package:dart_ice_and_fire/iceAndFireNav.dart';
import 'package:dart_ice_and_fire/iceTheme.dart';
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
      theme: iceTheme,
      home: IceAndFireNav(),
    );
  }
}
