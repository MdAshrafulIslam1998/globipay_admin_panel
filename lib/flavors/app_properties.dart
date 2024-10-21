import 'flavor_config.dart';

class AppProperties {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.DEV:
        return 'Globi Admin Panel Dev';
      case Flavor.UAT:
        return 'Globi Admin Panel UAT';
      case Flavor.PROD:
        return 'Globi Admin Panel';
      default:
        return 'Globi Admin Panel';
    }
  }

}
