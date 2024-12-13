// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_session_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatSessionResponse _$ChatSessionResponseFromJson(Map<String, dynamic> json) =>
    ChatSessionResponse(
      session_id: json['session_id'] as String?,
      created_at: json['created_at'] as String?,
      category: json['category'] as String?,
      user_name: json['user_name'] as String?,
      avatar_url: json['avatar_url'] as String?,
      attachment: json['attachment'] as String?,
      last_message: json['last_message'] as String?,
      isTyping: json['isTyping'] as bool?,
      customer_id: json['customer_id'] as String?,
      status: json['status'] as String?,
    )
      ..last_message_timestamp = json['last_message_timestamp'] as String?
      ..is_receiver_typing = json['is_receiver_typing'] as bool?
      ..is_sender_typing = json['is_sender_typing'] as bool?
      ..is_last_message_seen = json['is_last_message_seen'] as bool?
      ..message_type = json['message_type'] as String?;

Map<String, dynamic> _$ChatSessionResponseToJson(
        ChatSessionResponse instance) =>
    <String, dynamic>{
      'session_id': instance.session_id,
      'created_at': instance.created_at,
      'category': instance.category,
      'user_name': instance.user_name,
      'avatar_url': instance.avatar_url,
      'attachment': instance.attachment,
      'last_message': instance.last_message,
      'isTyping': instance.isTyping,
      'customer_id': instance.customer_id,
      'last_message_timestamp': instance.last_message_timestamp,
      'is_receiver_typing': instance.is_receiver_typing,
      'is_sender_typing': instance.is_sender_typing,
      'is_last_message_seen': instance.is_last_message_seen,
      'message_type': instance.message_type,
      'status': instance.status,
    };
