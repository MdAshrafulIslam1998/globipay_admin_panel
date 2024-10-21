import 'package:flutter/material.dart';

/**
 * Created by Abdullah on 11/10/24.
 */

class IconButtonModel {
  final String? title;
  final dynamic id;
  final isSvg;
  final String? networkIcon;
  final IconData? iconData;
  final String? localImage;
  final Color? color;
  final Color? backgroundColor;

  IconButtonModel({
    this.title,
    this.networkIcon,
    this.id,
    this.iconData,
    this.isSvg=true,
    this.localImage,
    this.color,
    this.backgroundColor
  });
}
