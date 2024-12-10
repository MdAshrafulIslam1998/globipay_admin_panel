/**
 * Created by Abdullah on 1/11/24.
 *//*


import 'package:flutter/material.dart';
import 'package:pip_view/pip_view.dart';
import 'package:wakelock/wakelock.dart';

class PiPVideoCallScreen extends StatefulWidget {
  final dynamic data;

  const PiPVideoCallScreen({Key? key, this.data}) : super(key: key);

  @override
  _PiPVideoCallScreenState createState() => _PiPVideoCallScreenState();
}

class _PiPVideoCallScreenState extends State<PiPVideoCallScreen> {
  late VideoCallController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(VideoCallController());
    controller.callInit(widget.data);
    _enableWakelock();
  }

  void _enableWakelock() async {
    await Wakelock.enable();
  }

  @override
  void dispose() {
    Wakelock.disable();
    super.dispose();
    controller.timer?.cancel();
    _dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PiPView(
      builder: (context, isInPiPMode) {
        return WillPopScope(
          onWillPop: () async {
            if (!isInPiPMode) {
              PiPView.of(context).enterPiP();
              return false;
            }
            return true;
          },
          child: Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              children: [
                // Your existing video call UI
                Positioned.fill(
                  child: Obx(() =>
                  controller.isCameraOff.value
                      ? audioCallBackground()
                      : videoCallBackground()
                  ),
                ),

                // Only show these widgets when not in PiP mode
                if (!isInPiPMode) ...[
                  // Call duration and other UI elements
                  Positioned(
                    top: 100,
                    left: 0,
                    right: 0,
                    child: buildCallHeader(),
                  ),

                  // Self view
                  Obx(() =>
                  controller.isCameraOff.value == false
                      ? buildSelfView()
                      : Container()
                  ),

                  // Control buttons
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: buildCallControls(),
                  ),
                ],

                // Show minimal controls in PiP mode
                if (isInPiPMode)
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: IconButton(
                      icon: Icon(Icons.call_end, color: Colors.red),
                      onPressed: () {
                        controller.endCall();
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

// Your existing widget methods...
}*/
