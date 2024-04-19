import 'package:fc_ui/fc_ui.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// [FCTheme] is a theme that can be used to style the UI of the app.
class FCTheme {
  const FCTheme._();

  static const FlexSchemeData _fcFlexShemeData = FlexSchemeData(
    name: 'Flut Cast Theme',
    description: 'Flut Cast theme, custom definition of all colors',
    light: FlexSchemeColor(
      primary: Palette.red,
      secondary: Palette.grey,
    ),
    dark: FlexSchemeColor(
      primary: Palette.red,
      secondary: Palette.grey,
    ),
  );

  /// [dark] is the default theme for Flut Cast.
  static final dark = FlexThemeData.dark(
    colors: _fcFlexShemeData.dark,
    scaffoldBackground: Palette.black,
    fontFamily: FontFamily.sFProDisplay,
  ).copyWith(
    colorScheme: const ColorScheme.dark(onSecondary: Palette.grey),
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      backgroundColor: Palette.dark,
      elevation: 0,
      titleSpacing: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    textTheme: TextStyles.dark,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Palette.red,
    ),
  );
}
