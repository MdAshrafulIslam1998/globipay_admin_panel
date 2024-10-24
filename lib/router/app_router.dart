// lib/router/app_router.dart
import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/modules/404_not_found/views/not_found_screen.dart';
import 'package:globipay_admin_panel/modules/splash/views/splash_screen_builder.dart';
import 'package:globipay_admin_panel/router/route_names.dart';
import 'package:globipay_admin_panel/router/route_paths.dart';
import 'package:go_router/go_router.dart';
import '../core/widgets/app_scaffold.dart';

final appRouter = GoRouter(
  initialLocation: RoutePaths.splash,
  routes: [
    GoRoute(
      path: RoutePaths.splash,
      name: RouteNames.splash,
      builder: (context, state) => SplashScreenBuilder(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return AppScaffold(
          currentRoute: state.location ?? RoutePaths.dashboard, // Changed fullpath to location
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: RoutePaths.dashboard,
          name: RouteNames.dashboard,
          builder: (context, state) => const Text('Dashboard'), // Add your dashboard screen
        ),
        GoRoute(
          path: RoutePaths.transactionHistory,
          name: RouteNames.transactionHistory,
          builder: (context, state) => const Text('Transactions'), // Add your transaction screen
        ),
        GoRoute(
          path: RoutePaths.settings,
          name: RouteNames.settings,
          builder: (context, state) => const Text('Settings'), // Add your settings screen
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const NotFoundScreen(),
);
