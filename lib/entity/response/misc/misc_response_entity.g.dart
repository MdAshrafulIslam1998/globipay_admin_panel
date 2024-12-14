// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'misc_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MiscResponseEntity _$MiscResponseEntityFromJson(Map<String, dynamic> json) =>
    MiscResponseEntity(
      services: (json['services'] as List<dynamic>?)
          ?.map(
              (e) => MiscResponseItemEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MiscResponseEntityToJson(MiscResponseEntity instance) =>
    <String, dynamic>{
      'services': instance.services,
      'pagination': instance.pagination,
    };
