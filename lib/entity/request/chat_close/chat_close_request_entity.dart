import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
/**
 * Created by Abdullah on 13/12/24.
 */

part 'chat_close_request_entity.g.dart';

@JsonSerializable()
class ChatCloseRequestEntity {
  @JsonKey(name: "catId")
  int? catId;
  @JsonKey(name: "uid")
  String? uid;
  @JsonKey(name: "primary_coin")
  double? primaryCoin;
  @JsonKey(name: "secondary_coin")
  double? secondaryCoin;
  @JsonKey(name: "createdBy")
  String? createdBy;

  ChatCloseRequestEntity({
    this.catId,
    this.uid,
    this.primaryCoin,
    this.secondaryCoin,
    this.createdBy,
  });

  factory ChatCloseRequestEntity.fromJson(Map<String, dynamic> json) => _$ChatCloseRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ChatCloseRequestEntityToJson(this);
}
