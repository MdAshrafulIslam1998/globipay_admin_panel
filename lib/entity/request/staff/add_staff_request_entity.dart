import 'package:json_annotation/json_annotation.dart';
/**
 * Created by Abdullah on 15/12/24.
 */

part 'add_staff_request_entity.g.dart';

@JsonSerializable()
class AddStaffRequestEntity {
   String? name;
   String? email;
   String? password;
   String? role;
   String? created_by;
   String? status;

  AddStaffRequestEntity({
     this.name,
     this.email,
     this.password,
     this.role,
     this.created_by,
     this.status,

  });

  factory AddStaffRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$AddStaffRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AddStaffRequestEntityToJson(this);


}