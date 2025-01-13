import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/di/injector.dart';
import 'package:globipay_admin_panel/core/theme/color_palettes.dart';
import 'package:globipay_admin_panel/di/app_injector.dart';
import 'package:globipay_admin_panel/modules/chat/call/video_call/widgets/call_circle_button.dart';
import 'package:globipay_admin_panel/modules/chat/call/video_call/widgets/controller/call_controller_widget_controller.dart';

/// Created by Abdullah on 26/10/24.

class CallControlWidget extends StatelessWidget {
  Function(bool state) toggleMutePressed;
  Function(bool state) toggleCameraPressed;
  Function(bool state) switchCameraPressed;
  Function() endCallPressed;


  CallControlWidget({
    super.key,
    required this.toggleMutePressed,
    required this.toggleCameraPressed,
    required this.switchCameraPressed,
    required this.endCallPressed,
  });

  // Centralized colors for easy theming
  final Color primaryColor = ColorPalettes.colorPrimary;
  final Color accentColor = Colors.redAccent;



  @override
  Widget build(BuildContext context) {
    CallControllerWidgetController controller =
    Injector.resolve<CallControllerWidgetController>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Mute Button
            Obx(
              () => CircleButton(
                icon: Icons.mic_off,
                onPressed: () {
                  toggleMutePressed(controller.isMuted.value);
                  controller.toggleMute();
                },
                color:
                    controller.isMuted == true ? primaryColor : accentColor,
              ),
            ),

            // Camera Toggle Button
            Obx(
              () => CircleButton(
                icon: Icons.videocam_off,
                onPressed: (){
                  toggleCameraPressed(controller.isCameraOff.value);
                  controller.toggleCamera();
                },
                color: controller.isCameraOff == true
                    ? primaryColor
                    : accentColor,
              ),
            ),

            // Switch Camera Button
            Obx(
              () => CircleButton(
                icon: Icons.cameraswitch,
                onPressed: () {
                  switchCameraPressed(controller.isFrontCamera.value);
                  controller.switchCamera();
                },
                color: controller.isFrontCamera == true
                    ? primaryColor
                    : accentColor,
              ),
            ),

            // End Call Button
            CircleButton(
              icon: Icons.call_end,
              onPressed: endCallPressed,
              color: accentColor,
            ),
          ],
        ),
      ],
    );
  }
}
