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
      phone: json['phone'] as String?,
      levelId: (json['level_id'] as num?)?.toInt(),
      levelName: json['level_name'] as String?,
      status: json['status'] as String?,
      date: json['date'] as String?,
      primary: (json['primary'] as num?)?.toDouble(),
      secondary: (json['secondary'] as num?)?.toDouble(),
      pushToken: json['push_token'] as String?,
      user_code: json['user_code'] as String?,
    )
      ..address = json['address'] as String?
      ..gender = json['gender'] as String?;

Map<String, dynamic> _$UserResponseItemEntityToJson(
        UserResponseItemEntity instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'level_id': instance.levelId,
      'level_name': instance.levelName,
      'status': instance.status,
      'date': instance.date,
      'primary': instance.primary,
      'secondary': instance.secondary,
      'push_token': instance.pushToken,
      'address': instance.address,
      'gender': instance.gender,
      'user_code': instance.user_code,
    };
