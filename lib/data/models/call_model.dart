/**
 * Created by Abdullah on 27/10/24.
 */

// lib/models/call_model.dart
class CallModel {
   String callerName;
   String callerImage;
   String channelName;
   String videoToken;
   bool isJoin = false;


  CallModel({
    required this.callerName,
    required this.callerImage,
    required this.channelName,
    required this.videoToken,
    required this.isJoin,
  });

  Map<String, dynamic> toJson() => {
    'callerName': callerName,
    'callerImage': callerImage,
    'channelName': channelName,
    'videoToken': videoToken,
    'isJoin': isJoin,
  };

  factory CallModel.fromJson(Map<String, dynamic> json) => CallModel(
    callerName: json['callerName'],
    callerImage: json['callerImage'],
    channelName: json['channelName'],
    videoToken: json['videoToken'],
    isJoin: json['isJoin'],
  );
}