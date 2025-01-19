// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_user_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatUserItem _$ChatUserItemFromJson(Map<String, dynamic> json) => ChatUserItem(
      userId: json['user_id'] as String?,
      name: json['name'] as String?,
      avatarUrl: json['avatar_url'],
      status: json['status'] as String?,
      role: json['role'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      fcmToken: json['fcm_token'] as String?,
      userActiveChat: json['user_active_chat'] as bool?,
    );

Map<String, dynamic> _$ChatUserItemToJson(ChatUserItem instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'name': instance.name,
      'avatar_url': instance.avatarUrl,
      'status': instance.status,
      'role': instance.role,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'fcm_token': instance.fcmToken,
      'user_active_chat': instance.userActiveChat,
    };
