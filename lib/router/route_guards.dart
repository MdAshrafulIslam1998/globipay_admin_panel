import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteGuards {
  static String? authGuard(BuildContext context, GoRouterState state) {
    // Add your authentication logic here
    // Example:
    // final isAuthenticated = AuthService.isAuthenticated;
    // if (!isAuthenticated && state.location != RoutePaths.splash) {
    //   return RoutePaths.splash;
    // }
    return null;
  }

  static String? roleGuard(BuildContext context, GoRouterState state) {
    // Add your role-based access control logic here
    // Example:
    // final userRole = AuthService.userRole;
    // if (userRole != 'admin' && state.location.startsWith('/admin')) {
    //   return RoutePaths.dashboard;
    // }
    return null;
  }
}