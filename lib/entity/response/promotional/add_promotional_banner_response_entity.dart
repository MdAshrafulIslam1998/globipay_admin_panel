/**
 * Created by Abdullah on 14/12/24.
 */

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'add_promotional_banner_response_entity.g.dart';

AddPromotionalBannerResponseEntity addPromotionalBannerResponseEntityFromJson(String str) => AddPromotionalBannerResponseEntity.fromJson(json.decode(str));

String addPromotionalBannerResponseEntityToJson(AddPromotionalBannerResponseEntity data) => json.encode(data.toJson());

@JsonSerializable()
class AddPromotionalBannerResponseEntity {
  @JsonKey(name: "id")
  int? id;

  AddPromotionalBannerResponseEntity({
    this.id,
  });

  factory AddPromotionalBannerResponseEntity.fromJson(Map<String, dynamic> json) => _$AddPromotionalBannerResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AddPromotionalBannerResponseEntityToJson(this);
}
