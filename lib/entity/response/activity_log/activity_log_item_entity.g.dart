// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_log_item_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityLogItemEntity _$ActivityLogItemEntityFromJson(
        Map<String, dynamic> json) =>
    ActivityLogItemEntity(
      id: (json['id'] as num?)?.toInt(),
      url: json['url'] as String?,
      method: json['method'] as String?,
      userId: json['user_id'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$ActivityLogItemEntityToJson(
        ActivityLogItemEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'method': instance.method,
      'user_id': instance.userId,
      'status': instance.status,
      'created_at': instance.createdAt,
      'type': instance.type,
    };
