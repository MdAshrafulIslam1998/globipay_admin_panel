// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_staff_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllStaffResponseEntity _$AllStaffResponseEntityFromJson(
        Map<String, dynamic> json) =>
    AllStaffResponseEntity(
      templates: (json['templates'] as List<dynamic>)
          .map((e) => AllStaffItemEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AllStaffResponseEntityToJson(
        AllStaffResponseEntity instance) =>
    <String, dynamic>{
      'templates': instance.templates,
      'pagination': instance.pagination,
    };
