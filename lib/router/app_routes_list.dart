import 'package:globipay_admin_panel/modules/base_panel/views/base_panel_screen.dart';
import 'package:globipay_admin_panel/modules/dashboard/views/dashboard_screen.dart';
import 'package:globipay_admin_panel/modules/users/active_users/views/active_users_screen.dart';
import 'package:globipay_admin_panel/modules/users/views/users_screen.dart';
import 'package:go_router/go_router.dart';
import 'route_path.dart';

abstract class AppRoutesList {
  static List<RouteBase> allRoutes() {
    return [
      ShellRoute(
        builder: (context, state, child) {
          return BasePanelScreen(child: child);
        },
        routes: [
        GoRoute(
          path: RoutePath.dashboard,
          builder: (context, state) => DashboardScreen(),
        ),
        GoRoute(
          path: RoutePath.users,
          builder: (context, state) => UsersScreen(),
        ),
        GoRoute(
          path: RoutePath.activeUsers,
          builder: (context, state) => ActiveUsersScreen(),
        ),
        ],
      ),
    ];
  }
}
