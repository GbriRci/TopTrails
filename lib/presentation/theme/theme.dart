import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.brown.shade400,
  scaffoldBackgroundColor: Color.fromARGB(255, 248, 245, 237),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.brown.shade400,
    foregroundColor: Colors.black,
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.brown.shade400,
    secondary: Colors.green.shade600,
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.brown.shade800,
  scaffoldBackgroundColor: Colors.grey.shade900,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.brown.shade800,
    foregroundColor: Colors.white,
  ),
  colorScheme: ColorScheme.dark(
    primary: Colors.brown.shade800,
    secondary: Colors.green.shade800,
  ),
);
