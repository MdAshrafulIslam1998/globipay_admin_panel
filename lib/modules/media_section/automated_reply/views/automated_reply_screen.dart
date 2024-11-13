import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/modules/media_section/automated_reply/controller/automated_reply_controller.dart';
import 'package:globipay_admin_panel/modules/media_section/automated_reply/views/automated_reply_screen_builder.dart';

class AutomatedReplyScreen extends StatelessWidget {
  const AutomatedReplyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AutomatedReplyController()); // Ensure the controller is registered here
    return AutomatedReplyScreenBuilder(controller: controller);
  }
}
