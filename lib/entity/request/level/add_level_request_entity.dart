import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

/**
 * Created by Abdullah on 15/12/24.
 */

part 'add_level_request_entity.g.dart';

AddLevelRequestEntity addLevelRequestEntityFromJson(String str) => AddLevelRequestEntity.fromJson(json.decode(str));

String addLevelRequestEntityToJson(AddLevelRequestEntity data) => json.encode(data.toJson());

@JsonSerializable()
class AddLevelRequestEntity {
  @JsonKey(name: "level_name")
  String? levelName;
  @JsonKey(name: "level_value")
  int? levelValue;
  @JsonKey(name: "min_thresh")
  double? minThresh;
  @JsonKey(name: "max_thresh")
  double? maxThresh;
  @JsonKey(name: "created_by")
  String? createdBy;

  AddLevelRequestEntity({
    this.levelName,
    this.levelValue,
    this.minThresh,
    this.maxThresh,
    this.createdBy,
  });

  factory AddLevelRequestEntity.fromJson(Map<String, dynamic> json) => _$AddLevelRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AddLevelRequestEntityToJson(this);
}
