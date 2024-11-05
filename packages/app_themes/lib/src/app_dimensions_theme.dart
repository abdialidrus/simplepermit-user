import 'package:flutter/material.dart';

///
class AppDimensionsTheme extends ThemeExtension<AppDimensionsTheme> {
  ///
  factory AppDimensionsTheme.main() => const AppDimensionsTheme._internal(
        radiusHelpIndication: 8,
        paddingHelpIndication:
            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      );

  const AppDimensionsTheme._internal({
    required this.radiusHelpIndication,
    required this.paddingHelpIndication,
  });

  ///
  final double radiusHelpIndication;

  ///
  final EdgeInsets paddingHelpIndication;

  @override
  ThemeExtension<AppDimensionsTheme> copyWith() {
    return AppDimensionsTheme._internal(
      radiusHelpIndication: radiusHelpIndication,
      paddingHelpIndication: paddingHelpIndication,
    );
  }

  @override
  ThemeExtension<AppDimensionsTheme> lerp(
    covariant ThemeExtension<AppDimensionsTheme>? other,
    double t,
  ) =>
      this;
}
