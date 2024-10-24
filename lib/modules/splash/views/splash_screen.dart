import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/modules/splash/controller/splash_controller.dart';
import 'package:globipay_admin_panel/modules/splash/views/splash_screen_builder.dart';


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(context), // Pass the context here
      builder: (_) => SplashScreenBuilder(),
    );
  }
}
