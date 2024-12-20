// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationResponseEntity _$NotificationResponseEntityFromJson(
        Map<String, dynamic> json) =>
    NotificationResponseEntity(
      notifications: (json['notifications'] as List<dynamic>?)
          ?.map((e) => NotificationResponseItemEntity.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NotificationResponseEntityToJson(
        NotificationResponseEntity instance) =>
    <String, dynamic>{
      'notifications': instance.notifications,
    };
