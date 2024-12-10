/**
 * Created by Abdullah on 31/10/24.
 *//*


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/widgets/app_print.dart';
import 'package:globipay_admin_panel/data/models/call_model.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:globipay_admin_panel/router/route_path.dart';

class CallHandlerService {
  static const String CALL_CHANNEL_ID = "call_channel";
  static const String CALL_CHANNEL_NAME = "Video Calls";

  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  // Call states
  final RxBool isInCall = false.obs;
  final RxBool isIncomingCall = false.obs;
  final RxString currentCallId = "".obs;

  Future<void> initialize() async {
    // Configure Android call screen
    final AndroidNotificationChannel callChannel = AndroidNotificationChannel(
      CALL_CHANNEL_ID,
      CALL_CHANNEL_NAME,
      importance: Importance.max,
      enableVibration: true,
      playSound: true,
      enableLights: true,
      ledColor: const Color.fromARGB(255, 255, 0, 0),
    );

    await _notificationsPlugin.initialize(
      InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          notificationCategories: [
            DarwinNotificationCategory(
              'call_cat',
              actions: [
                DarwinNotificationAction.plain('accept', 'Accept'),
                DarwinNotificationAction.plain('decline', 'Decline'),
              ],
              options: <DarwinNotificationCategoryOption>{
                DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
              },
            ),
          ],
        ),
      ),
      onDidReceiveNotificationResponse: _handleNotificationResponse,
    );

    // Create the call notification channel
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(callChannel);
  }

  Future<void> handleIncomingCall(RemoteMessage message) async {
    if (!isInCall.value) {
      final callData = message.data;
      currentCallId.value = callData['callId'] ?? "";
      isIncomingCall.value = true;

      appPrint(tag: "Incoming Call", 'Incoming call: $callData');
      // Show full-screen incoming call UI
      if (GetPlatform.isAndroid) {
        await _showAndroidIncomingCall(callData);
      } else if (GetPlatform.isIOS) {
        await _showIOSIncomingCall(callData);
      }
    }
  }


  Future<void> _showAndroidIncomingCall(Map<String, dynamic> callData,) async {
    final androidDetails = await getCallNotificationDetails(callData);

    // Show notification
    await _notificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'Incoming Video Call',
      '${callData['callerName'] ?? "Unknown"} is calling...',
      NotificationDetails(
        android: androidDetails,
      ),
      payload: callData.toString(),
    );


  }

  Future<void> _showIOSIncomingCall(Map<String, dynamic> callData) async {
    final DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'ringtone.aiff',
      categoryIdentifier: 'call_cat',
      threadIdentifier: callData['callId'],
    );

    await _notificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      "Incoming Call",
      callData['callerName'] ?? "Unknown",
      NotificationDetails(iOS: iosDetails),
      payload: callData.toString(),
    );
  }

  Future<AndroidNotificationDetails> getCallNotificationDetails(Map<String, dynamic> callData) async {
    return AndroidNotificationDetails(
      CALL_CHANNEL_ID,
      CALL_CHANNEL_NAME,
      importance: Importance.max,
      priority: Priority.max,
      fullScreenIntent: true,
      enableVibration: true,
      playSound: true,
      showWhen: true,
      when: DateTime.now().millisecondsSinceEpoch,
      ongoing: true,
      autoCancel: true,
      category: AndroidNotificationCategory.call,
      color: const Color(0xFF2196F3),
      colorized: true,
      visibility: NotificationVisibility.public,
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction(
          'accept',
          'Accept',
          showsUserInterface: true,
          titleColor: const Color(0xFF4CAF50),
        ),
        AndroidNotificationAction(
          'decline',
          'Decline',
          showsUserInterface: true,
          titleColor: const Color(0xFFE53935),
          cancelNotification: true,
        ),
      ],
      styleInformation: BigTextStyleInformation(
        callData['callerName'] ?? 'Unknown',
        htmlFormatTitle: true,
        htmlFormatBigText: true,
        htmlFormatContent: true,
        contentTitle: '<b>Incoming Video Call</b>',
        htmlFormatContentTitle: true,
      ),
    );
  }


  Future<void> _handleNotificationResponse(NotificationResponse response) async {
    if (response.actionId == 'accept') {
      // Handle call accept
      await acceptCall(response);
    } else if (response.actionId == 'decline' || response.actionId == 'end_call') {
      // Handle call decline/end
      await endCall();
    }
  }

  Future<void> acceptCall(NotificationResponse response) async {
    isIncomingCall.value = false;
    isInCall.value = true;

    //CallModel callModel = CallModel.fromJson(response.payload);


    //AppRoutes.pushNamed(RoutePath.callPickUp,extra:  callModel);

    appPrint("Call Accepted : ${response.payload}");
  }

  Future<void> endCall() async {
    isIncomingCall.value = false;
    isInCall.value = false;
    currentCallId.value = "";
    await _notificationsPlugin.cancel(0);
  }
}*/
