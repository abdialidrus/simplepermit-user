import 'package:app_themes/src/app_colors_theme.dart';
import 'package:app_themes/src/app_dimensions_theme.dart';
import 'package:app_themes/src/app_texts_theme.dart';

/// {@template app_themes}
/// This package contains app themes such as colors, text styles,
/// and dimensions.
/// {@endtemplate}
class AppThemes {
  /// {@macro app_themes}
  const AppThemes();

  ///
  AppDimensionsTheme getAppDimensionsTheme() => AppDimensionsTheme.main();

  ///
  AppColorsTheme getAppColorsTheme() => AppColorsTheme.light();

  ///
  AppTextsTheme getAppTextsTheme() => AppTextsTheme.main();
}
