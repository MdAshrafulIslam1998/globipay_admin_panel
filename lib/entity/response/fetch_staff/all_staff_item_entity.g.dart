// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_staff_item_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllStaffItemEntity _$AllStaffItemEntityFromJson(Map<String, dynamic> json) =>
    AllStaffItemEntity(
      staffId: (json['staff_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      status: json['status'] as String?,
      roleName: json['role_name'] as String?,
      accessList: json['access_list'] as String?,
    );

Map<String, dynamic> _$AllStaffItemEntityToJson(AllStaffItemEntity instance) =>
    <String, dynamic>{
      'staff_id': instance.staffId,
      'name': instance.name,
      'email': instance.email,
      'status': instance.status,
      'role_name': instance.roleName,
      'access_list': instance.accessList,
    };
