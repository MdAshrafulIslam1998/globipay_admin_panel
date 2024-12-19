import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/constants/app_constant.dart';
import 'package:globipay_admin_panel/core/data/model/icon_button_model.dart';
import 'package:globipay_admin_panel/core/theme/color_palettes.dart';
import 'package:globipay_admin_panel/core/widgets/text/app_text.dart';

/**
 * Created by Abdullah on 11/10/24.
 */

class AppOutlineButton extends StatelessWidget {
  final String text;
  final Function()? onPress;
  final Color? backgroundColor;
  final Color? textColor;
  final MainAxisAlignment? mainAxisAlignment;

  const AppOutlineButton({
    super.key,
    required this.text,
    required this.onPress,
    this.backgroundColor,
    this.textColor,
    this.mainAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPress,
        style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size(double.infinity, AppConstants.buttonHeight)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(
                  color: textColor ?? ColorPalettes.colorPrimary,
                ),
              ),
            ),
            backgroundColor: WidgetStateProperty.all(backgroundColor)),
        child: AppText(
          text,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: textColor ?? ColorPalettes.colorPrimary,
              ),
        ));
  }
}
