import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_view_state.dart';
import 'package:globipay_admin_panel/core/constants/app_spaces.dart';
import 'package:globipay_admin_panel/core/theme/color_palettes.dart';
import 'package:globipay_admin_panel/core/utils/app_utils.dart';
import 'package:globipay_admin_panel/modules/chat/call/video_call/controller/video_cal_controller.dart';
import 'package:globipay_admin_panel/modules/chat/call/video_call/widgets/call_circle_button.dart';
import 'package:globipay_admin_panel/modules/chat/call/video_call/widgets/call_control_widget.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';

import 'audio_profile_view.dart';



class VideoCallScreenBuilder extends StatefulWidget {
  final dynamic data;

  const VideoCallScreenBuilder({super.key, this.data});

  @override
  _VideoCallScreenState createState() => _VideoCallScreenState();
}

class _VideoCallScreenState
    extends BaseViewState<VideoCallScreenBuilder, VideoCallController>
    with TickerProviderStateMixin {


  String? securedEmojis;




  @override
  void initState() {
    controller.callInit(widget.data);
    securedEmojis = AppUtils.getSecuredCallEmojis();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.timer?.cancel();
    _dispose();
  }

  Future<void> _dispose() async {
    await controller.engine.leaveChannel();
    await controller.engine.release();
  }



  @override
  Widget body(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
          children: [
            // Show different backgrounds based on video toggle
           Obx(()=> Positioned.fill(
              child:
                  controller.isCameraOff.value ? audioCallBackground() : videoCallBackground(),
            ),),

            // Call status text positioned at the top center
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                // Optional horizontal padding
                child: Column(
                  children: [
                    AppSpaces.spaceBetweenChild,
                    Text(
                      securedEmojis ?? "", // Get 4 to 5 emojis
                      style: const TextStyle(
                        fontSize: 18, // Match the size of call status text
                      ),
                    ),

                    AppSpaces.spaceBetweenChild,
                    // Call Duration Text
                    Obx(()=>Text(
                      AppUtils.formatDuration(controller.callDuration.value),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),),

                  ],
                ),
              ),
            ),

            // Self View (small video window if video is on)
            Obx(()=> controller.isCameraOff.value == false ? Positioned(
              right: 20,
              bottom: 160,
              child: Draggable(
                feedback: selfViewWidget(),
                childWhenDragging: Container(),
                child: selfViewWidget(),
              ),
            ) : Container()),

            // Control Buttons
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: CallControlWidget(
                toggleMutePressed: (state){
                  controller.toggleMute(state);
                },
                toggleCameraPressed: (state){
                  controller.toggleCamera();

                },
                switchCameraPressed: (state){
                  controller.switchCamera();

                },
                endCallPressed: () {
                  AppRoutes.pop();
                },
              ),
            ),
          ],

      ),
    );
  }

  // Widget for the video call background (when video is on)
  Widget videoCallBackground() {
    return Container(
      color: Colors.grey[900], // Simulated video background
      child: Center(
        child: Obx(() => controller.remoteUid.value != 0
            ? AgoraVideoView(
          controller: VideoViewController.remote(
            rtcEngine: controller.engine,
            canvas: VideoCanvas(uid: controller.remoteUid.value),
            connection: RtcConnection(
              channelId: widget.data.channelName,
            ),
          ),
        )
            : const Center(child: CircularProgressIndicator())),
      ),
    );
  }

  // Widget for the audio call background (color-shifting animation)
  Widget audioCallBackground() {
    return const AudioCallProfileView(
      userName: "John Doe",
      userImageUrl:
          "https://static.remove.bg/sample-gallery/graphics/bird-thumbnail.jpg", // Replace with actual user image URL
    );
  }

  // Self-view widget (small camera view)
  Widget selfViewWidget() {
    return Container(
      width: 120,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.black26,
        border: Border.all(color: Colors.white54),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: AgoraVideoView(
          controller: VideoViewController(
            rtcEngine: controller.engine,
            canvas: const VideoCanvas(uid: 0),
          ),
        ),
      ),
    );
  }

}
