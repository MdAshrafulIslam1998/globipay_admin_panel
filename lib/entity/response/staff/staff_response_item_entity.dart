import 'package:json_annotation/json_annotation.dart';
/**
 * Created by Abdullah on 15/12/24.
 */


part 'staff_response_item_entity.g.dart';

@JsonSerializable()
class StaffResponseItemEntity {
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

  StaffResponseItemEntity({
    this.staffId,
    this.name,
    this.email,
    this.status,
    this.roleName,
    this.accessList,
  });

  factory StaffResponseItemEntity.fromJson(Map<String, dynamic> json) => _$StaffResponseItemEntityFromJson(json);

  Map<String, dynamic> toJson() => _$StaffResponseItemEntityToJson(this);
}
