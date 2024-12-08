import 'package:globipay_admin_panel/router/route_path.dart';
import 'package:go_router/go_router.dart';
import 'package:globipay_admin_panel/core/services/navigator/app_navigator_service.dart';

/**
 * Created by Abdullah on 21/8/24.
 */

GoRouter routerConfig({routesList}) {
  return GoRouter(
      routes: routesList,
      navigatorKey: AppNavigatorService.navigatorKey,
      initialLocation: RoutePath.start
  );
}