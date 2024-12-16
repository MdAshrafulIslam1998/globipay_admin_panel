// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_notification_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateNotificationRequestEntity _$CreateNotificationRequestEntityFromJson(
        Map<String, dynamic> json) =>
    CreateNotificationRequestEntity(
      token: json['token'] as String?,
      userId: json['user_id'] as String?,
      title: json['title'] as String?,
      details: json['details'] as String?,
      richMediaUrl: json['rich_media_url'] as String?,
      deepLink: json['deep_link'] as String?,
    );

Map<String, dynamic> _$CreateNotificationRequestEntityToJson(
        CreateNotificationRequestEntity instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user_id': instance.userId,
      'title': instance.title,
      'details': instance.details,
      'rich_media_url': instance.richMediaUrl,
      'deep_link': instance.deepLink,
    };
