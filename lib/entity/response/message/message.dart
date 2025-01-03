import 'package:json_annotation/json_annotation.dart';

/**
 * Created by Abdullah on 19/10/24.
 */

part 'message.g.dart';
@JsonSerializable()
class Message {
  String? id; // Unique ID for the message
  String? sender_id; // User ID of the sender
  String? receiver_id; // User ID of the receiver
  String? message; // Text message (if it's a text)
  String? media_url; // URL for media (image, video, etc.)
  String? message_type; // Type: 'text', 'image', 'video', 'file', 'voice'
  String? status; // Status: 'sent', 'delivered', 'seen', 'deleted'
  String? created_at; // Timestamp for when the message was created
  String? updated_at; // Timestamp for when the message was last updated
  String? delivered_at; // Timestamp for when the message was delivered
  String? seen_at; // Timestamp for when the message was seen
  String? message_from;
  Map<String, dynamic>? delivery_status;

  Message({
    this.id,
    this.sender_id,
    this.receiver_id,
    this.message,
    this.media_url,
    this.message_type,
    this.status,
    this.created_at,
    this.updated_at,
    this.delivered_at,
    this.seen_at,
    this.message_from,
    this.delivery_status,
  });

  bool get isSent => delivery_status?['sent'] != null;
  bool get isDelivered => delivery_status?['delivered'] != null;
  bool get isSeen => delivery_status?['seen'] != null;

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

}
