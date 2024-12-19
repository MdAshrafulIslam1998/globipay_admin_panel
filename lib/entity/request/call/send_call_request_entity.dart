import 'package:json_annotation/json_annotation.dart';

/**
 * Created by Abdullah on 19/12/24.
 */

import 'dart:convert';

part 'send_call_request_entity.g.dart';

SendCallRequestEntity sendCallRequestEntityFromJson(String str) => SendCallRequestEntity.fromJson(json.decode(str));

String sendCallRequestEntityToJson(SendCallRequestEntity data) => json.encode(data.toJson());

@JsonSerializable()
class SendCallRequestEntity {
  @JsonKey(name: "token")
  String? token;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "body")
  String? body;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "caller_name")
  String? callerName;
  @JsonKey(name: "caller_image")
  String? callerImage;
  @JsonKey(name: "channel")
  String? channel;
  @JsonKey(name: "video_token")
  String? videoToken;

  SendCallRequestEntity({
    this.token,
    this.title,
    this.body,
    this.image,
    this.type,
    this.callerName,
    this.callerImage,
    this.channel,
    this.videoToken,
  });

  factory SendCallRequestEntity.fromJson(Map<String, dynamic> json) => _$SendCallRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SendCallRequestEntityToJson(this);
}
