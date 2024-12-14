import 'package:globipay_admin_panel/entity/response/pagination/pagination.dart';
import 'package:globipay_admin_panel/entity/response/promotional/promotional_banner_item.dart';
import 'package:json_annotation/json_annotation.dart';

/**
 * Created by Abdullah on 14/12/24.
 */
part 'promotional_banner_response_entity.g.dart';
@JsonSerializable()
class PromotionalBannerResponseEntity{
  List<PromotionalBannerItem>? sliders;
  Pagination? pagination;

  PromotionalBannerResponseEntity({
    this.sliders,
    this.pagination,
  });

  factory PromotionalBannerResponseEntity.fromJson(Map<String, dynamic> json) => _$PromotionalBannerResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionalBannerResponseEntityToJson(this);

}