import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
/**
 * Created by Abdullah on 15/12/24.
 */

part 'add_category_request_entity.g.dart';

AddCategoryRequestEntity addCategoryRequestEntityFromJson(String str) => AddCategoryRequestEntity.fromJson(json.decode(str));

String addCategoryRequestEntityToJson(AddCategoryRequestEntity data) => json.encode(data.toJson());

@JsonSerializable()
class AddCategoryRequestEntity {
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "created_by")
  String? createdBy;
  @JsonKey(name: "bgcolor")
  String? bgcolor;

  AddCategoryRequestEntity({
    this.name,
    this.image,
    this.createdBy,
    this.bgcolor,
  });

  factory AddCategoryRequestEntity.fromJson(Map<String, dynamic> json) => _$AddCategoryRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AddCategoryRequestEntityToJson(this);
}
