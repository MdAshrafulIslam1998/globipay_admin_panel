import 'package:globipay_admin_panel/modules/base_panel/views/base_panel_screen.dart';
import 'package:globipay_admin_panel/modules/dashboard/views/dashboard_screen.dart';
import 'package:globipay_admin_panel/modules/active_users/views/active_users_screen.dart';
import 'package:globipay_admin_panel/modules/inactive_users/views/inactive_users_screen.dart';
import 'package:globipay_admin_panel/modules/transactions/views/transactions_screen.dart';
import 'package:globipay_admin_panel/modules/pending_transactions/views/pending_transactions_screen.dart';
import 'package:globipay_admin_panel/modules/settings/views/settings_screen.dart';
import 'package:globipay_admin_panel/modules/edit_coin/views/edit_coin_screen.dart';
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
          path: RoutePath.inactiveUsers,
          builder: (context, state) => InactiveUsersScreen(),
        ),
        GoRoute(
          path: RoutePath.transactions,
          builder: (context, state) => TransactionsScreen(),
        ),
        GoRoute(
          path: RoutePath.pendingTransactions,
          builder: (context, state) => PendingTransactionsScreen(),
        ),
        GoRoute(
          path: RoutePath.settings,
          builder: (context, state) => SettingsScreen(),
        ),
        GoRoute(
          path: RoutePath.pendingTransactions,
          builder: (context, state) => PendingTransactionsScreen(),
        ),
        GoRoute(
          path: RoutePath.editCoin,
          builder: (context, state) => EditCoinScreen(),
        ),
        ],
      ),
    ];
  }
}
