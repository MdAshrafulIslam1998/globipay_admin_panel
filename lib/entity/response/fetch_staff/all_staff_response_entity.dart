/**
 * Created by Abdullah on 14/12/24.
 */

import 'package:globipay_admin_panel/entity/response/fetch_staff/all_staff_item_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import '../pagination/pagination.dart';

part 'all_staff_response_entity.g.dart';

@JsonSerializable()

class AllStaffResponseEntity {

  @JsonKey(name: "templates")
  List<AllStaffItemEntity> templates;
  @JsonKey(name: "pagination")
  Pagination? pagination;

  AllStaffResponseEntity({
    required this.templates,
    this.pagination,
  });

  factory AllStaffResponseEntity.fromJson(Map<String, dynamic> json) => _$AllStaffResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AllStaffResponseEntityToJson(this);
}