import 'package:json_annotation/json_annotation.dart';
/**
 * Created by Abdullah on 19/12/24.
 */

part 'agora_token_request_entity.g.dart';

@JsonSerializable()
class AgoraTokenRequestEntity {
  String? channelName;

  AgoraTokenRequestEntity({
    this.channelName,
  });

  factory AgoraTokenRequestEntity.fromJson(Map<String, dynamic> json) => _$AgoraTokenRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AgoraTokenRequestEntityToJson(this);
}