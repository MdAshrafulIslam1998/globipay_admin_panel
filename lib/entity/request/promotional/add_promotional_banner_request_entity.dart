import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

/**
 * Created by Abdullah on 14/12/24.
 */

part 'add_promotional_banner_request_entity.g.dart';

AddPromotionalBannerRequestEntity addPromotionalBannerRequestEntityFromJson(String str) => AddPromotionalBannerRequestEntity.fromJson(json.decode(str));

String addPromotionalBannerRequestEntityToJson(AddPromotionalBannerRequestEntity data) => json.encode(data.toJson());

@JsonSerializable()
class AddPromotionalBannerRequestEntity {
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "subtitle")
  String? subtitle;
  @JsonKey(name: "created_by")
  String? createdBy;
  @JsonKey(name: "send_type")
  String? sendType;
  @JsonKey(name: "send_to")
  dynamic sendTo;
  @JsonKey(name: "action")
  String? action;
  @JsonKey(name: "from_date")
  String? fromDate;
  @JsonKey(name: "to_date")
  String? toDate;
  @JsonKey(name: "slider_index")
  int? sliderIndex;
  @JsonKey(name: "picture")
  String? picture;
  String? bgColor;

  AddPromotionalBannerRequestEntity({
    this.title,
    this.subtitle,
    this.createdBy,
    this.sendType,
    this.sendTo,
    this.action,
    this.fromDate,
    this.toDate,
    this.sliderIndex,
    this.picture,
    this.bgColor,
  });

  factory AddPromotionalBannerRequestEntity.fromJson(Map<String, dynamic> json) => _$AddPromotionalBannerRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AddPromotionalBannerRequestEntityToJson(this);
}
