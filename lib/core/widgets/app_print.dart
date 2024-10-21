
import 'package:flutter/foundation.dart';
import 'package:globipay_admin_panel/flavors/flavor_config.dart';

/**
 * Created by Abdullah on 13/10/24.
 */

appPrint(data, {tag}) {
  if (kDebugMode || (FlavorConfig.instance.flavor == Flavor.DEV)) {
    if (tag == null) {
      //  logger.d(data);
      print(":: $data");

    } else {
      print("${tag.toString().toUpperCase()} :: $data");
    }
  }
}