/**
 * Created by Abdullah on 20/8/24.
 */

import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/theme/color_palettes.dart';
import 'package:globipay_admin_panel/core/theme/theme_style/button_theme.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    primaryColor: ColorPalettes.colorPrimary,
    elevatedButtonTheme: elevatedButtonThemeDataLight,
    outlinedButtonTheme: outlinedButtonThemeDataLight,
    focusColor: ColorPalettes.colorPrimary,
    indicatorColor: ColorPalettes.colorIndicator,
    //buttonTheme: buttonThemeDataLight
    // Define more customizations
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blueGrey,
    // Define more customizations
  );
}
