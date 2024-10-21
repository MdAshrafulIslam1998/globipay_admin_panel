import 'package:globipay_admin_panel/modules/splash_screen.dart';
import 'package:go_router/go_router.dart';

/**
 * Created by Abdullah on 21/8/24.
 */

abstract class AppRoutesList {
  static allRoutes() {
    return [
      GoRoute(
        path: '/',
        name: '/',
        builder: (context, state) => SplashScreen(),
      ),

    ];
  }
}
