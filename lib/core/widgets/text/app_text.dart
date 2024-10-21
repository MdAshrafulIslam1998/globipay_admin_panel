/**
 * Created by Abdullah on 10/10/24.
 */

import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/theme/color_palettes.dart';
import 'package:globipay_admin_panel/core/widgets/text/app_text_type.dart';

class AppText extends StatelessWidget {
  final title;
  final TextStyle? style;
  final AppTextType? type;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLine;
  final bool? softWrap;
  final int? maxLength;
  final StrutStyle? strutStyle;

  const AppText(this.title,
      {super.key,
        this.style,
        this.maxLine,
        this.type,
        this.color,
        this.textAlign,
        this.strutStyle,
        this.overflow,
        this.maxLength,
        this.softWrap})
      : assert(style == null || type == null,
  'You cannot provide both, style and type');


  @override
  Widget build(BuildContext context) {
    var newText;
    if(maxLength!=null){
      newText = (title.length > maxLength ? title.substring(0, maxLength):title)+"...";
    }
    return Text(
      newText?? title ?? "",
      style: getStyle(context),
      textAlign: textAlign,
      overflow: overflow,
      softWrap: softWrap,
      maxLines: maxLine,
      strutStyle: strutStyle,
    );
  }

  getStyle(context) {
    if (style != null) {
      return style?.copyWith(color: color);
    }

    var textTheme = Theme.of(context).textTheme;

    switch (type) {
      case AppTextType.bodyLarge:
        return textTheme.bodyLarge?.copyWith(color: color);
      case AppTextType.bodyMedium:
        return textTheme.bodyMedium?.copyWith(color: color);
      case AppTextType.bodySmall:
        return textTheme.bodySmall?.copyWith(color: color);

      case AppTextType.labelLarge:
        return textTheme.labelLarge?.copyWith(color: color);
      case AppTextType.labelMedium:
        return textTheme.labelMedium?.copyWith(color: color);
      case AppTextType.labelSmall:
        return textTheme.labelSmall?.copyWith(color: color);

      case AppTextType.titleLarge:
        return textTheme.titleLarge?.copyWith(color: color);
      case AppTextType.titleMedium:
        return textTheme.titleMedium?.copyWith(color: color);
      case AppTextType.titleSmall:
        return textTheme.titleSmall?.copyWith(color: color);

      case AppTextType.headlineLarge:
        return textTheme.headlineLarge?.copyWith(color: color);
      case AppTextType.headlineMedium:
        return textTheme.headlineMedium?.copyWith(color: color);
      case AppTextType.headlineSmall:
        return textTheme.headlineSmall?.copyWith(color: color);

      case AppTextType.displayLarge:
        return textTheme.displayLarge?.copyWith(color: color);
      case AppTextType.displayMedium:
        return textTheme.displayMedium?.copyWith(color: color);
      case AppTextType.displaySmall:
        return textTheme.displaySmall?.copyWith(color: color);

      default:
        return TextStyle(color: color);
    }
  }

}
