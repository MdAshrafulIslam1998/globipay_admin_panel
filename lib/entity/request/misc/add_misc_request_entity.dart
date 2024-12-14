import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

/**
 * Created by Abdullah on 15/12/24.
 */

part 'add_misc_request_entity.g.dart';

@JsonSerializable()
class AddMiscRequestEntity {
  @JsonKey(name: "featureCode")
  String? featureCode;
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "content")
  String? content;

  AddMiscRequestEntity({
    this.featureCode,
    this.type,
    this.content,
  });

  factory AddMiscRequestEntity.fromJson(Map<String, dynamic> json) => _$AddMiscRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AddMiscRequestEntityToJson(this);
}
