import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/constants/app_constant.dart';
import 'package:globipay_admin_panel/core/constants/app_edge_insets.dart';
import 'package:globipay_admin_panel/core/constants/app_radius.dart';
import 'package:globipay_admin_panel/core/theme/color_palettes.dart';
import 'package:globipay_admin_panel/core/theme/theme_style/text_theme.dart';


/**
 * Created by Abdullah on 11/10/24.
 */

ButtonThemeData buttonThemeDataLight =  ButtonThemeData(
  textTheme: ButtonTextTheme.normal,
  buttonColor: ColorPalettes.buttonPrimaryColor,
  height: AppConstants.buttonHeight,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: ColorPalettes.buttonPrimaryColor,
    onPrimary: ColorPalettes.buttonPrimaryColor,
    secondary: ColorPalettes.transparent,
    onSecondary: ColorPalettes.transparent,
    error: ColorPalettes.buttonPrimaryColor,
    onError: ColorPalettes.buttonPrimaryColor,
    background: ColorPalettes.buttonPrimaryColor,
    onBackground: ColorPalettes.buttonPrimaryColor,
    surface: ColorPalettes.buttonPrimaryColor,
    onSurface: ColorPalettes.buttonPrimaryColor,
  ),
);

ElevatedButtonThemeData elevatedButtonThemeDataLight = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: ColorPalettes.buttonPrimaryColor,
      textStyle: bodyLightLarge.copyWith(color: ColorPalettes.whiteColor),
      side: BorderSide(color: ColorPalettes.transparent, width: 0),
      shape: AppRadius.defaultButtonBorderRound,
      padding: AppEdgeInsets.all15,
    ));

OutlinedButtonThemeData outlinedButtonThemeDataLight = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: Size(double.infinity, AppConstants.buttonHeight),
      backgroundColor: ColorPalettes.transparent,
      textStyle: bodyLightLarge.copyWith(color: ColorPalettes.colorPrimary),
      shape: AppRadius.defaultButtonBorderRound,
      side: BorderSide(color: ColorPalettes.colorPrimary , width: 1),
      padding: AppEdgeInsets.all15,
    ));

// Dark

ButtonThemeData buttonThemeDataDark =  ButtonThemeData(
  textTheme: ButtonTextTheme.normal,
  height: AppConstants.buttonHeight,
  buttonColor: ColorPalettes.buttonPrimaryColor,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: ColorPalettes.buttonPrimaryColor,
    onPrimary: ColorPalettes.buttonPrimaryColor,
    secondary: ColorPalettes.transparent,
    onSecondary: ColorPalettes.transparent,
    error: ColorPalettes.buttonPrimaryColor,
    onError: ColorPalettes.buttonPrimaryColor,
    background: ColorPalettes.buttonPrimaryColor,
    onBackground: ColorPalettes.buttonPrimaryColor,
    surface: ColorPalettes.buttonPrimaryColor,
    onSurface: ColorPalettes.buttonPrimaryColor,
  ),
);

ElevatedButtonThemeData elevatedButtonThemeDataDark = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: ColorPalettes.buttonPrimaryColor,
        textStyle:
        bodyLightLarge.copyWith(color: ColorPalettes.buttonSecondaryColor),
        shape: AppRadius.defaultButtonBorderRound,
        padding: AppEdgeInsets.all15));

OutlinedButtonThemeData outlinedButtonThemeDataDark = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        backgroundColor: ColorPalettes.transparent,
        textStyle: bodyLightLarge.copyWith(color: ColorPalettes.colorPrimary),
        shape: AppRadius.defaultButtonBorderRound,
        side: BorderSide(color: ColorPalettes.buttonPrimaryColor, width: 1),
        padding: AppEdgeInsets.all15));
