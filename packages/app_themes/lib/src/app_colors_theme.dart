import 'package:flutter/material.dart';

/// Defines the colors of the app.
class AppColorsTheme extends ThemeExtension<AppColorsTheme> {
  /// factory for dark mode:
  factory AppColorsTheme.dark() {
    return const AppColorsTheme._internal(
      backgroundDefault: _grey,
      backgroundInput: _grey,
      snackbarValidation: _green,
      snackbarError: _red,
      textDefault: _grey,
    );
  }

  const AppColorsTheme._internal({
    required this.backgroundDefault,
    required this.backgroundInput,
    required this.snackbarValidation,
    required this.snackbarError,
    required this.textDefault,
  });

  /// factory for light mode:
  factory AppColorsTheme.light() {
    return const AppColorsTheme._internal(
      backgroundDefault: _grey,
      backgroundInput: _grey,
      snackbarValidation: _green,
      snackbarError: _red,
      textDefault: _grey,
    );
  }
  // reference colors:
  static const _grey = Color(0xFFB0B0B0);
  static const _green = Color(0xFF00C060);
  static const _red = Color(0xFFED4E52);

  /// The default background color of the app.
  final Color backgroundDefault;

  /// The default background color of text inputs.
  final Color backgroundInput;

  /// The color of the snackbar validation.
  final Color snackbarValidation;

  /// The color of the snackbar error.
  final Color snackbarError;

  /// The default text color of the app.
  final Color textDefault;

  @override
  ThemeExtension<AppColorsTheme> copyWith({bool? lightMode}) {
    if (lightMode == null || lightMode == true) {
      return AppColorsTheme.light();
    }
    return AppColorsTheme.dark();
  }

  @override
  ThemeExtension<AppColorsTheme> lerp(
    covariant ThemeExtension<AppColorsTheme>? other,
    double t,
  ) =>
      this;
}
