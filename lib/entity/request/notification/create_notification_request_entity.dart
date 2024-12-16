// To parse this JSON data, do
//
//     final createNotificationRequestEntity = createNotificationRequestEntityFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'create_notification_request_entity.g.dart';

CreateNotificationRequestEntity createNotificationRequestEntityFromJson(String str) => CreateNotificationRequestEntity.fromJson(json.decode(str));

String createNotificationRequestEntityToJson(CreateNotificationRequestEntity data) => json.encode(data.toJson());

@JsonSerializable()
class CreateNotificationRequestEntity {
  @JsonKey(name: "token")
  String? token;
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

  CreateNotificationRequestEntity({
    this.token,
    this.userId,
    this.title,
    this.details,
    this.richMediaUrl,
    this.deepLink,
  });

  factory CreateNotificationRequestEntity.fromJson(Map<String, dynamic> json) => _$CreateNotificationRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CreateNotificationRequestEntityToJson(this);
}
