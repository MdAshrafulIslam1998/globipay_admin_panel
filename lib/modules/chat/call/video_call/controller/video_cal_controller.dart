import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/core/widgets/app_print.dart';
import 'package:globipay_admin_panel/data/models/call_model.dart';

/**
 * Created by Abdullah on 26/10/24.
 */
const appId = "f808b49bca754c88aa1cab9d0fc789ce";


class VideoCallController extends BaseController{

  static const int timeoutSeconds = 30; // Call timeout duration


   Rx<CallModel?> currentCall = Rx<CallModel?>(null);
   RxBool isMuted = false.obs;
   RxBool isVideoEnabled = true.obs;
   RxBool isSpeakerOn = true.obs;
   RxBool isConnectionPoor = false.obs;
   RxBool isJoined = false.obs;
   RxInt remoteUid = 0.obs;



  //RX variables
  RxBool isCameraOff = false.obs;
  RxBool isFrontCamera = true.obs;

  Timer? timer;
  RxInt callDuration = 0.obs;

  CallModel? callModel;
  late RtcEngine engine;



  void callInit(CallModel call) {
    engine = createAgoraRtcEngine();
    callModel = call;
    _initializeMethods();



  }

  void _initializeMethods() {
    initAgoraEngine();

    _startTimer();
  }

  Future<void> initAgoraEngine() async {

    await engine.initialize(
        RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    await engine.enableVideo();
    await engine.startPreview();

    engine.registerEventHandler(RtcEngineEventHandler(
      onJoinChannelSuccess: (connection, elapsed) {
        isJoined.value = true;
        appPrint("Join channel success, channel: ${callModel?.channelName}");
      },
      onUserJoined: (connection, uid, elapsed) {
        remoteUid.value = uid;
        appPrint("User $uid joined");
      },
      onUserOffline: (connection, uid, reason) {
        remoteUid.value = 0;
        appPrint("User $uid left");
        endCall();
      },

    ));

    if(callModel!.isJoin) {
      joinCall(callModel!.channelName, callModel!.videoToken);
    }else {
      makeCall(callModel!.channelName, callModel!.videoToken);
    }
  }

  Future<void> makeCall(String channelName, String token) async {
    try {
      // Set the user as a broadcaster (who will be seen and heard)
      await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster, );

      // Enable video and audio for the user
      await engine.enableVideo();
      await engine.enableAudio();

      // Optionally, start the local preview before joining the channel
      await engine.startPreview();

      // Join the specified channel
      await engine.joinChannel(
        token: token,
        channelId: channelName,
        uid: 0, // Use 0 to let Agora assign a UID automatically
        options: const ChannelMediaOptions(
          autoSubscribeAudio: true,
          autoSubscribeVideo: true,
        ),
      );

      print("Call initiated on channel: $channelName");
    } catch (e) {
      print("Error in makeCall: $e");
    }
  }


  Future<void> joinCall(String channelName, String token, {bool isBroadcaster = true}) async {
    try {
      // Set the user role depending on if they want to be a broadcaster or audience
      await engine.setClientRole(role:
        isBroadcaster
            ? ClientRoleType.clientRoleBroadcaster
            : ClientRoleType.clientRoleAudience,
      );

      // Enable necessary media depending on role
      if (isBroadcaster) {
        await engine.enableVideo();
        await engine.enableAudio();
        await engine.startPreview(); // Start the local preview if broadcaster
      }

      // Join the specified channel
      await engine.joinChannel(
        token: token,
        channelId: channelName,
        uid: 0, // Use 0 to let Agora assign a UID automatically
        options: const ChannelMediaOptions(
          autoSubscribeAudio: true,
          autoSubscribeVideo: true,
        ),
      );

      print("Joined call on channel: $channelName as ${isBroadcaster ? 'Broadcaster' : 'Audience'}");
    } catch (e) {
      print("Error in joinCall: $e");
    }
  }




  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      callDuration.value++;
    });
  }
  // Simulate actions with a controller
  void toggleMute(bool state) {
    isMuted.value = !isMuted.value;
    engine.muteLocalAudioStream(isMuted.value);

  }

  void toggleCamera() {
    isCameraOff.value = !isCameraOff.value;
    engine.muteLocalVideoStream(isCameraOff.value);
    if (isCameraOff.value == true) {
      engine.disableVideo();
      engine.enableAudio();
    } else {
      engine.enableVideo();
      engine.enableAudio();
    }
  }

  void switchCamera() {
    /*isFrontCamera.value = !isFrontCamera.value;
    engine.muteLocalVideoStream(!isVideoEnabled.value);*/
    engine.switchCamera();


  }

  void startCallTimeout() {
    Future.delayed(const Duration(seconds: 60), () {
      if (!isJoined.value) {
        endCall();
      }
    });
  }

  Future<void> endCall() async {
    await engine.leaveChannel();
    currentCall.value = null;
    Get.back();
  }

  @override
  void onClose() {
    super.onClose();
  }

}