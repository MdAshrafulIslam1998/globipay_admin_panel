import 'package:globipay_admin_panel/modules/base_panel/views/base_panel_screen.dart';
import 'package:globipay_admin_panel/modules/dashboard/views/dashboard_screen.dart';
import 'package:globipay_admin_panel/modules/active_users/views/active_users_screen.dart';
import 'package:globipay_admin_panel/modules/edit_coin/views/edit_coin_screen.dart';
import 'package:globipay_admin_panel/modules/pending_profile/views/pending_profile_screen.dart';
import 'package:globipay_admin_panel/modules/notification_setter/views/notification_setter_screen.dart';
import 'package:globipay_admin_panel/modules/active_users_new/views/active_users_new_screen.dart';
import 'package:globipay_admin_panel/modules/pending_users/views/pending_users_screen.dart';
import 'package:globipay_admin_panel/modules/blocked_users/views/blocked_users_screen.dart';
import 'package:globipay_admin_panel/modules/user_levels/views/user_levels_screen.dart';
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
          path: RoutePath.activeUsers,
          builder: (context, state) => ActiveUsersScreen(),
        ),
        GoRoute(
          path: RoutePath.editCoin,
          builder: (context, state) => EditCoinScreen(),
        ),
        GoRoute(
          path: RoutePath.pendingProfile,
          builder: (context, state) => PendingProfileScreen(),
        ),
        GoRoute(
          path: RoutePath.notificationSetter,
          builder: (context, state) => NotificationSetterScreen(),
        ),
        GoRoute(
          path: RoutePath.activeUsersNew,
          builder: (context, state) => ActiveUsersNewScreen(),
        ),
        GoRoute(
          path: RoutePath.pendingUsers,
          builder: (context, state) => PendingUsersScreen(),
        ),
        GoRoute(
          path: RoutePath.blockedUsers,
          builder: (context, state) => BlockedUsersScreen(),
        ),
        GoRoute(
          path: RoutePath.userLevels,
          builder: (context, state) => UserLevelsScreen(),
        ),
        ],
      ),
    ];
  }
}
