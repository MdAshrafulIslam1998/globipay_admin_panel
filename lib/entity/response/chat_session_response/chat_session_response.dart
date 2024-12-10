import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
/**
 * Created by Abdullah on 21/10/24.
 */


part 'chat_session_response.g.dart';

@JsonSerializable()
class ChatSessionResponse {
  String? session_id;
  String? created_at;
  String? category;
  String? user_name;
  String? avatar_url;
  String? attachment;
  String? last_message;
  bool? isTyping;
  String? customer_id;
  String? last_message_timestamp;
  bool? is_receiver_typing;
  bool? is_sender_typing;
  bool? is_last_message_seen;
  String? message_type;

  ChatSessionResponse({
    this.session_id,
    this.created_at,
    this.category,
    this.user_name,
    this.avatar_url,
    this.attachment,
    this.last_message,
    this.isTyping,
    this.customer_id,

  });

  factory ChatSessionResponse.fromJson(Map<String, dynamic> json) => _$ChatSessionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatSessionResponseToJson(this);
}
