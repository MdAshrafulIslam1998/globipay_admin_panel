// To parse this JSON data, do
//
//     final levelItemResponseEntity = levelItemResponseEntityFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'level_item_response_entity.g.dart';

LevelItemResponseEntity levelItemResponseEntityFromJson(String str) => LevelItemResponseEntity.fromJson(json.decode(str));

String levelItemResponseEntityToJson(LevelItemResponseEntity data) => json.encode(data.toJson());

@JsonSerializable()
class LevelItemResponseEntity {
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
  @JsonKey(name: "date")
  String? date;
  @JsonKey(name: "levid")
  int? levid;

  LevelItemResponseEntity({
    this.levelName,
    this.levelValue,
    this.minThresh,
    this.maxThresh,
    this.createdBy,
    this.date,
    this.levid,
  });

  factory LevelItemResponseEntity.fromJson(Map<String, dynamic> json) => _$LevelItemResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LevelItemResponseEntityToJson(this);
}
