// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_staff_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddStaffRequestEntity _$AddStaffRequestEntityFromJson(
        Map<String, dynamic> json) =>
    AddStaffRequestEntity(
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      role: json['role'] as String?,
      created_by: json['created_by'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$AddStaffRequestEntityToJson(
        AddStaffRequestEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'role': instance.role,
      'created_by': instance.created_by,
      'status': instance.status,
    };
