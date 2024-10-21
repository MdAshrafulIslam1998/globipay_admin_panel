import 'package:flutter_svg/svg.dart';

/**
 * Created by Abdullah on 11/10/24.
 */

class AppSvgImage extends SvgPicture {
  AppSvgImage.asset(super.assetName,
      {super.height,
      super.alignment,
      super.allowDrawingOutsideViewBox,
      super.bundle,
      super.clipBehavior,
      super.colorFilter,
      super.excludeFromSemantics,
      super.fit,
      super.theme,
      super.width,
      super.placeholderBuilder,
      super.semanticsLabel,
      super.matchTextDirection,
      super.package,
      super.key})
      : super.asset();
}
