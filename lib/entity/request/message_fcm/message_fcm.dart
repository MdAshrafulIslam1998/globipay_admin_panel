
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
/**
 * Created by Abdullah on 20/1/25.
 */

part 'message_fcm.g.dart';

MessageFcm messageFcmFromJson(String str) => MessageFcm.fromJson(json.decode(str));

String messageFcmToJson(MessageFcm data) => json.encode(data.toJson());

@JsonSerializable()
class MessageFcm {
  @JsonKey(name: "user_id")
  String? userId;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "details")
  String? details;
  @JsonKey(name: "rich_media_url")
  String? richMediaUrl;
  @JsonKey(name: "deep_link")
  String? deepLink;

  MessageFcm({
    this.userId,
    this.title,
    this.details,
    this.richMediaUrl,
    this.deepLink,
  });

  factory MessageFcm.fromJson(Map<String, dynamic> json) => _$MessageFcmFromJson(json);

  Map<String, dynamic> toJson() => _$MessageFcmToJson(this);
}
