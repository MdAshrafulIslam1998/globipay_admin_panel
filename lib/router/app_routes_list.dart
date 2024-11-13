import 'package:get/get.dart';
import 'package:globipay_admin_panel/modules/amount_section/trans_history/views/trans_history_screen.dart';
import 'package:globipay_admin_panel/modules/dashboard_section/base_panel/views/base_panel_screen.dart';
import 'package:globipay_admin_panel/modules/dashboard_section/dashboard/views/dashboard_screen.dart';
import 'package:globipay_admin_panel/modules/users_section/active_users/views/active_users_screen.dart';
import 'package:globipay_admin_panel/modules/amount_section/edit_coin/views/edit_coin_screen.dart';
import 'package:globipay_admin_panel/modules/users_section/pending_profile/views/pending_profile_screen.dart';
import 'package:globipay_admin_panel/modules/media_section/notification_setter/views/notification_setter_screen.dart';
import 'package:globipay_admin_panel/modules/users_section/active_users_new/views/active_users_new_screen.dart';
import 'package:globipay_admin_panel/modules/users_section/pending_users/views/pending_users_screen.dart';
import 'package:globipay_admin_panel/modules/users_section/blocked_users/views/blocked_users_screen.dart';
import 'package:globipay_admin_panel/modules/users_section/user_levels/views/user_levels_screen.dart';
import 'package:globipay_admin_panel/modules/users_section/user_amount/views/user_amount_screen.dart';
import 'package:globipay_admin_panel/modules/amount_section/create_category/views/create_category_screen.dart';
import 'package:globipay_admin_panel/modules/media_section/promo_banner/views/promo_banner_screen.dart';
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
        GoRoute(
          path: RoutePath.userAmount,
          builder: (context, state) => UserAmountScreen(),
        ),
        GoRoute(
          path: RoutePath.transHistory,
          builder: (context, state) => TransactionHistoryScreen(),
        ),
        GoRoute(
          path: RoutePath.createCategory,
          builder: (context, state) => CreateCategoryScreen(),
        ),
        GoRoute(
          path: RoutePath.promoBanner,
          builder: (context, state) => PromoBannerScreen(),
        ),
        ],
      ),
    ];
  }
}
