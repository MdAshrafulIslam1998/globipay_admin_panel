// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response_item_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponseItemEntity _$UserResponseItemEntityFromJson(
        Map<String, dynamic> json) =>
    UserResponseItemEntity(
      userId: json['user_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      levelId: (json['level_id'] as num?)?.toInt(),
      levelName: json['level_name'] as String?,
      status: json['status'] as String?,
      date: json['date'] as String?,
      primary: (json['primary'] as num?)?.toDouble(),
      secondary: (json['secondary'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UserResponseItemEntityToJson(
        UserResponseItemEntity instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'level_id': instance.levelId,
      'level_name': instance.levelName,
      'status': instance.status,
      'date': instance.date,
      'primary': instance.primary,
      'secondary': instance.secondary,
    };
