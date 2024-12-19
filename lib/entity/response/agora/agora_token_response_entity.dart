import 'package:json_annotation/json_annotation.dart';
/**
 * Created by Abdullah on 19/12/24.
 */

part 'agora_token_response_entity.g.dart';

@JsonSerializable()
class AgoraTokenResponseEntity {
  String? token;

  AgoraTokenResponseEntity({
    this.token,
  });

  factory AgoraTokenResponseEntity.fromJson(Map<String, dynamic> json) => _$AgoraTokenResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AgoraTokenResponseEntityToJson(this);
}