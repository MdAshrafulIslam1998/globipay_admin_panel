// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StaffResponseEntity _$StaffResponseEntityFromJson(Map<String, dynamic> json) =>
    StaffResponseEntity(
      staffs: (json['staffs'] as List<dynamic>?)
          ?.map((e) =>
              StaffResponseItemEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StaffResponseEntityToJson(
        StaffResponseEntity instance) =>
    <String, dynamic>{
      'staffs': instance.staffs,
      'pagination': instance.pagination,
    };
