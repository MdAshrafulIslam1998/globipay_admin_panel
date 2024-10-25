// 2. app_routes_list.dart
import 'package:globipay_admin_panel/modules/dashbaord/views/dashbaord_screen.dart';
import 'package:globipay_admin_panel/modules/users/views/users_screen.dart';
import 'package:globipay_admin_panel/router/route_path.dart';
import 'package:go_router/go_router.dart';

abstract class AppRoutesList {
  static allRoutes() {
    return [
      GoRoute(
        path: RoutePath.dashboard,
        name: RoutePath.dashboard,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: RoutePath.users,
        name: RoutePath.users,
        builder: (context, state) => const UsersScreen(),
      ),
     
    ];
  }
}