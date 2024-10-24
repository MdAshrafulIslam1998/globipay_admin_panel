import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/modules/splash/controller/splash_controller.dart';


class SplashScreenBuilder extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color for the splash screen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your splash screen logo or any content
            Image.asset(
              'assets/images/logo.png', // Replace with your logo path
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            // Optional text below the logo
            const Text(
              'Welcome to Globipay Admin Panel',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            // Optional loader to show progress
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
