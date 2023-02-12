import 'package:flutter/material.dart';
class AppThemes{
  // static final darkTheme = ThemeData(
  //   useMaterial3: true,
  //   scaffoldBackgroundColor: Colors.black,
  //   colorScheme: const ColorScheme.dark(),
  // );
  static final darkTheme = ThemeData.dark(
    useMaterial3: true,
  );

  static final lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
    ),
    useMaterial3: true,
    colorScheme: const ColorScheme.light(),
    scaffoldBackgroundColor: Colors.white,
  );
}