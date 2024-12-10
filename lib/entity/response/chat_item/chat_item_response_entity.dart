import 'package:json_annotation/json_annotation.dart';

/**
 * Created by Abdullah on 18/10/24.
 */

part 'chat_item_response_entity.g.dart';

@JsonSerializable()
class ChatItemResponseEntity {
  String? id;
  String? customerName;
  String? avatarUrl;
  String? lastMessage;
  String? time;
  String? status;
  String? attachment;
  String? currentUserId;
  String? chatPartnerId;
  bool isTyping; // Add this field
  String? category;


  ChatItemResponseEntity({
    this.id,
    this.customerName,
    this.avatarUrl,
    this.lastMessage,
    this.time,
    this.status,
    this.attachment,
    this.currentUserId,
    this.chatPartnerId,
    this.isTyping = false, // Initialize as false
    this.category,

  });

  factory ChatItemResponseEntity.fromJson(Map<String, dynamic> json) => _$ChatItemResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ChatItemResponseEntityToJson(this);

}