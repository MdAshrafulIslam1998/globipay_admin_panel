import 'package:get/get.dart';
import 'package:globipay_admin_panel/router/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashController extends GetxController {
  final BuildContext context;

  SplashController(this.context);

  @override
  void onInit() {
    super.onInit();
    _initSplash();
  }

  void _initSplash() async {
    await Future.delayed(const Duration(seconds: 5));

    // Navigate to the dashboard using GoRouter's context
    context.go(RoutePaths.dashboard);
  }
}
