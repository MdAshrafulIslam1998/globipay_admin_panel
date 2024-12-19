import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/constants/app_constant.dart';
import 'package:globipay_admin_panel/core/theme/color_palettes.dart';
import 'package:globipay_admin_panel/core/widgets/text/app_text.dart';

/**
 * Created by Abdullah on 11/10/24 12:03 AM.
 */

class AppButton extends StatelessWidget {
  AppButton({
    required this.text,
    required this.onPress,
    this.backgroundColor,
    this.textColor,
    this.height,
    this.width,
  });

  final Color? backgroundColor;
  final Color? textColor;
  final String text;
  final Function onPress;
  double? height;
  double? width;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // Ensures the ripple is visible on custom backgrounds
      child: Ink(
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).primaryColor, // Button background color
          borderRadius: BorderRadius.circular(12.0), // Optional: Customize corner radius
        ),
        child: InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            onPress();
          },
          borderRadius: BorderRadius.circular(16.0), // Match the radius of the decoration
          splashColor: Colors.white.withOpacity(0.3), // Customize ripple color
          child: Container(
            height: height ?? AppConstants.buttonHeight,
            width: width ?? double.infinity,
            alignment: Alignment.center,
            child: AppText(
              text,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: textColor ?? ColorPalettes.whiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
