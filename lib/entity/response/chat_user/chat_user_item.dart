import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

/**
 * Created by Abdullah on 19/1/25.
 */

part 'chat_user_item.g.dart';

@JsonSerializable()
class ChatUserItem {
  @JsonKey(name: "user_id")
  String? userId;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "avatar_url")
  dynamic avatarUrl;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "role")
  String? role;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "fcm_token")
  String? fcmToken;
  @JsonKey(name: "user_active_chat")
  bool? userActiveChat;

  ChatUserItem({
    this.userId,
    this.name,
    this.avatarUrl,
    this.status,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.fcmToken,
    this.userActiveChat,
  });

  factory ChatUserItem.fromJson(Map<String, dynamic> json) => _$ChatUserItemFromJson(json);

  Map<String, dynamic> toJson() => _$ChatUserItemToJson(this);
}
