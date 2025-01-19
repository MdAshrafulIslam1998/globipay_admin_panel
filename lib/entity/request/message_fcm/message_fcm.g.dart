// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_fcm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageFcm _$MessageFcmFromJson(Map<String, dynamic> json) => MessageFcm(
      userId: json['user_id'] as String?,
      title: json['title'] as String?,
      details: json['details'] as String?,
      richMediaUrl: json['rich_media_url'] as String?,
      deepLink: json['deep_link'] as String?,
    );

Map<String, dynamic> _$MessageFcmToJson(MessageFcm instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'title': instance.title,
      'details': instance.details,
      'rich_media_url': instance.richMediaUrl,
      'deep_link': instance.deepLink,
    };
