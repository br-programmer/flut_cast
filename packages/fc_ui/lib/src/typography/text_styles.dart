import 'package:fc_ui/fc_ui.dart';
import 'package:flutter/material.dart';

/// App Text Style Definitions
/// Source: https://m3.material.io/styles/typography/type-scale-tokens
class TextStyles {
  const TextStyles._();

  static const _baseTextStyle = TextStyle(
    fontFamily: FontFamily.sFProDisplay,
    fontWeight: AppFontWeight.semiBold,
    color: Palette.white,
    package: FCUI.package,
  );

  static TextStyle headlineSmall = _baseTextStyle.copyWith(
    fontSize: 20,
    fontWeight: AppFontWeight.medium,
  );

  static TextStyle headlineLarge = _baseTextStyle.copyWith(
    fontSize: 44,
    fontWeight: AppFontWeight.regular,
  );

  static TextStyle headlineMedium = _baseTextStyle.copyWith(fontSize: 32);

  static TextStyle displayLarge = _baseTextStyle.copyWith(
    fontSize: 28,
  );

  static TextStyle bodySmall = _baseTextStyle.copyWith(fontSize: 14);

  static TextStyle bodyMedium = _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: AppFontWeight.regular,
    color: Palette.white.withOpacity(.75),
  );

  static TextStyle bodyLarge = _baseTextStyle.copyWith(fontSize: 16);

  static TextStyle titleLarge = _baseTextStyle.copyWith(
    fontSize: 16,
    letterSpacing: -.75,
  );

  static TextStyle labelSmall = _baseTextStyle.copyWith(fontSize: 12);

  static TextStyle labelMedium = _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: AppFontWeight.regular,
    color: Palette.white.withOpacity(.8),
  );

  static TextStyle titleSmall = _baseTextStyle.copyWith(
    fontSize: 13,
    color: Palette.white.withOpacity(.6),
  );

  static TextTheme get dark => TextTheme(
        displayLarge: TextStyles.displayLarge,
        headlineSmall: TextStyles.headlineSmall,
        headlineMedium: TextStyles.headlineMedium,
        headlineLarge: TextStyles.headlineLarge,
        bodySmall: TextStyles.bodySmall,
        bodyMedium: TextStyles.bodyMedium,
        bodyLarge: TextStyles.bodyLarge,
        titleSmall: TextStyles.titleSmall,
        titleLarge: TextStyles.titleLarge,
        labelSmall: TextStyles.labelSmall,
        labelMedium: TextStyles.labelMedium,
      );
}
