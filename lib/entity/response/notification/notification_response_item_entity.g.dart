// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_response_item_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationResponseItemEntity _$NotificationResponseItemEntityFromJson(
        Map<String, dynamic> json) =>
    NotificationResponseItemEntity(
      id: (json['id'] as num?)?.toInt(),
      notificationId: (json['notification_id'] as num?)?.toInt(),
      title: json['title'] as String?,
      details: json['details'] as String?,
      richMediaUrl: json['rich_media_url'] as String?,
      deepLink: json['deep_link'] as String?,
      type: json['type'] as String?,
      time: json['time'] as String?,
      daysOfWeek: json['days_of_week'],
      startDate: json['start_date'],
      intervalMinutes: json['interval_minutes'],
      lastSentAt: json['last_sent_at'] as String?,
      status: json['status'] as String?,
      targetId: json['target_id'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      targetType: json['targetType'] as String?,
    );

Map<String, dynamic> _$NotificationResponseItemEntityToJson(
        NotificationResponseItemEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'notification_id': instance.notificationId,
      'title': instance.title,
      'details': instance.details,
      'rich_media_url': instance.richMediaUrl,
      'deep_link': instance.deepLink,
      'type': instance.type,
      'time': instance.time,
      'days_of_week': instance.daysOfWeek,
      'start_date': instance.startDate,
      'interval_minutes': instance.intervalMinutes,
      'last_sent_at': instance.lastSentAt,
      'status': instance.status,
      'target_id': instance.targetId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'targetType': instance.targetType,
    };
