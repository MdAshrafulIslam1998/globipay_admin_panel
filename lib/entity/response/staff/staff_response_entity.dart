import 'package:globipay_admin_panel/entity/response/staff/staff_response_item_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import '../pagination/pagination.dart';
/**
 * Created by Abdullah on 15/12/24.
 */

part 'staff_response_entity.g.dart';

@JsonSerializable()
class StaffResponseEntity {
  @JsonKey(name: "staffs")
  List<StaffResponseItemEntity>? staffs;
  @JsonKey(name: "pagination")
  Pagination? pagination;

  StaffResponseEntity({
    this.staffs,
    this.pagination,
  });

  factory StaffResponseEntity.fromJson(Map<String, dynamic> json) => _$StaffResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$StaffResponseEntityToJson(this);
}