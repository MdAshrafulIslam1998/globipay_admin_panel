// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_item_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatItemResponseEntity _$ChatItemResponseEntityFromJson(
        Map<String, dynamic> json) =>
    ChatItemResponseEntity(
      id: json['id'] as String?,
      customerName: json['customerName'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      lastMessage: json['lastMessage'] as String?,
      time: json['time'] as String?,
      status: json['status'] as String?,
      attachment: json['attachment'] as String?,
      currentUserId: json['currentUserId'] as String?,
      chatPartnerId: json['chatPartnerId'] as String?,
      isTyping: json['isTyping'] as bool? ?? false,
      category: json['category'] as String?,
    );

Map<String, dynamic> _$ChatItemResponseEntityToJson(
        ChatItemResponseEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerName': instance.customerName,
      'avatarUrl': instance.avatarUrl,
      'lastMessage': instance.lastMessage,
      'time': instance.time,
      'status': instance.status,
      'attachment': instance.attachment,
      'currentUserId': instance.currentUserId,
      'chatPartnerId': instance.chatPartnerId,
      'isTyping': instance.isTyping,
      'category': instance.category,
    };
