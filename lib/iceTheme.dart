import 'package:flutter/material.dart';

const ink = Color(0xff070b0f);
const panel = Color(0xff11161b);
const parchment = Color(0xffe8f3fe);
const frost = Color(0xffa9c6d7);
const ember = Color(0xffe08067);

final ThemeData iceTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: ink,
  colorScheme: const ColorScheme.dark(
    primary: frost,
    secondary: ember,
    surface: panel,
    onSurface: parchment,
  ),
  fontFamily: 'Georgia',
  appBarTheme: const AppBarTheme(
    backgroundColor: ink,
    foregroundColor: parchment,
    elevation: 0,
  ),
  dividerColor: const Color(0xff303a40),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: panel,
    indicatorColor: const Color(0xff263b47),
    labelTextStyle: WidgetStateProperty.all(
      const TextStyle(
        fontFamily: 'sans-serif',
        fontSize: 11,
        letterSpacing: .4,
      ),
    ),
  ),
);
