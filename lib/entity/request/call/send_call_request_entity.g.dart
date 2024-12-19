// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_call_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendCallRequestEntity _$SendCallRequestEntityFromJson(
        Map<String, dynamic> json) =>
    SendCallRequestEntity(
      token: json['token'] as String?,
      title: json['title'] as String?,
      body: json['body'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String?,
      callerName: json['caller_name'] as String?,
      callerImage: json['caller_image'] as String?,
      channel: json['channel'] as String?,
      videoToken: json['video_token'] as String?,
    );

Map<String, dynamic> _$SendCallRequestEntityToJson(
        SendCallRequestEntity instance) =>
    <String, dynamic>{
      'token': instance.token,
      'title': instance.title,
      'body': instance.body,
      'image': instance.image,
      'type': instance.type,
      'caller_name': instance.callerName,
      'caller_image': instance.callerImage,
      'channel': instance.channel,
      'video_token': instance.videoToken,
    };
