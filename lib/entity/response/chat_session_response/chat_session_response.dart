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
  String? status;
  String? categoryName;
  String? categoryImage;



  ChatSessionResponse(

  {

  this

      .

  session_id,
  this.created_at,
  this.category,
  this.user_name,
  this.avatar_url,
  this.attachment,
  this.last_message,
  this.isTyping,
  this.customer_id,
  this.last_message_timestamp,
  this.is_receiver_typing,
  this.is_sender_typing,
  this.is_last_message_seen,
  this.message_type,
  this.status,
  this.categoryName,
  this.categoryImage,
  });


  factory ChatSessionResponse.fromJson(Map<String, dynamic> json) => _$ChatSessionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatSessionResponseToJson(this);
}
