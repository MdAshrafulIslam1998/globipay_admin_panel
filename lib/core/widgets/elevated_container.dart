/// Created by Abdullah on 10/10/24.
library;
import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/theme/color_palettes.dart';

class ElevatedContainer extends StatelessWidget {
  final Widget child;
  final Color bgColor;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;

  const ElevatedContainer({
    super.key,
    required this.child,
    this.bgColor = ColorPalettes.colorSurface,
    this.padding,
    this.borderRadius = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: const [
            BoxShadow(
              color: ColorPalettes.colorSurface,
              spreadRadius:1,
              blurRadius: 2,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        color: ColorPalettes.colorSurface,
      ),
      child: child,
    );
  }
}