import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteUtils {
  static void pushNamed(
    BuildContext context,
    String routeName, {
    Map<String, String>? params,
    Map<String, String>? queryParams,
    Object? extra,
  }) {
    context.pushNamed(
      routeName,
      pathParameters: params ?? {},
      queryParameters: queryParams ?? {},
      extra: extra,
    );
  }

  static void goNamed(
    BuildContext context,
    String routeName, {
    Map<String, String>? params,
    Map<String, String>? queryParams,
    Object? extra,
  }) {
    context.goNamed(
      routeName,
      pathParameters: params ?? {},
      queryParameters: queryParams ?? {},
      extra: extra,
    );
  }

  static void pop<T>(BuildContext context, [T? result]) {
    if (context.canPop()) {
      context.pop(result);
    }
  }

  static void replaceWithRoute(BuildContext context, String routeName) {
    context.goNamed(routeName);
  }
}
