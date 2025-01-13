import 'package:json_annotation/json_annotation.dart';
/**
 * Created by Abdullah on 14/12/24.
 */

part 'promotional_banner_item.g.dart';
@JsonSerializable()
class PromotionalBannerItem {
  int? id;
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

  PromotionalBannerItem({
    this.id,
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

  factory PromotionalBannerItem.fromJson(Map<String, dynamic> json) =>
      _$PromotionalBannerItemFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionalBannerItemToJson(this);
}