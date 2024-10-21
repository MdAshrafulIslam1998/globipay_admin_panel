import 'package:cached_network_image/cached_network_image.dart';

/**
 * Created by Abdullah on 11/10/24.
 */

class AppNetworkImage extends CachedNetworkImage {
  AppNetworkImage(
      {super.key,
      required super.imageUrl,
      super.httpHeaders,
      super.height,
      super.fit,
      super.imageBuilder,
      super.progressIndicatorBuilder,
      super.placeholder,
      super.errorWidget,
      super.width});
}
