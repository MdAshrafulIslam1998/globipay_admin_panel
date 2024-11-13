import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';

class AboutUsController extends BaseController {
  final TextEditingController aboutUsContentController = TextEditingController();
  final RxBool isRunning = false.obs;

  @override
  void onClose() {
    aboutUsContentController.dispose();
    super.onClose();
  }

  void start() {
    isRunning.value = true;
    Get.snackbar(
      'Status Changed',
      'About Us section is now running',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void stop() {
    isRunning.value = false;
    Get.snackbar(
      'Status Changed',
      'About Us section has been stopped',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
