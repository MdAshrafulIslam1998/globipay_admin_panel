/**
 * Created by Abdullah on 14/12/24.
 */

import 'package:globipay_admin_panel/entity/response/category/category_item_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'all_staff_item_entity.g.dart';

@JsonSerializable()
class AllStaffItemEntity {
  @JsonKey(name: "staff_id")
  int? staffId;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "role_name")
  String? roleName;
  @JsonKey(name: "access_list")
  String? accessList;

  AllStaffItemEntity({
    this.staffId,
    this.name,
    this.email,
    this.status,
    this.roleName,
    this.accessList,
  });

  factory AllStaffItemEntity.fromJson(Map<String, dynamic> json) =>
      _$AllStaffItemEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AllStaffItemEntityToJson(this);
}
