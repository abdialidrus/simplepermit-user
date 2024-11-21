import 'package:flutter/material.dart';

class PermitAppTheme {
  static ThemeData get light {
    return ThemeData(
      appBarTheme: const AppBarTheme(color: Color(0xFFFFFFFF)),
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF0C0C26),
        onPrimary: Color(0xFFFFFFFF),
        secondary: Color(0xFF2D29D7),
        onSecondary: Color(0xFFFFFFFF),
        error: Color(0xFFD32F2F),
        onError: Color(0xFFFFFFFF),
        surface: Color(0xFFFFFFFF),
        onSurface: Color(0xFF0C0C26),
      ),
      scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      appBarTheme: const AppBarTheme(color: Color(0xFFFFFFFF)),
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF0C0C26),
        onPrimary: Color(0xFFFFFFFF),
        secondary: Color(0xFF2D29D7),
        onSecondary: Color(0xFFFFFFFF),
        error: Color(0xFFD32F2F),
        onError: Color(0xFFFFFFFF),
        surface: Color(0xFFFFFFFF),
        onSurface: Color(0xFF0C0C26),
      ),
      scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    );
  }
}
