// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['id'] as String?,
      sender_id: json['sender_id'] as String?,
      receiver_id: json['receiver_id'] as String?,
      message: json['message'] as String?,
      media_url: json['media_url'] as String?,
      message_type: json['message_type'] as String?,
      status: json['status'] as String?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
      delivered_at: json['delivered_at'] as String?,
      seen_at: json['seen_at'] as String?,
      message_from: json['message_from'] as String?,
      delivery_status: json['delivery_status'] as Map<String, dynamic>?,

);

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'sender_id': instance.sender_id,
      'receiver_id': instance.receiver_id,
      'message': instance.message,
      'media_url': instance.media_url,
      'message_type': instance.message_type,
      'status': instance.status,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'delivered_at': instance.delivered_at,
      'seen_at': instance.seen_at,
      'message_from': instance.message_from,
      'delivery_status': instance.delivery_status,
    };
