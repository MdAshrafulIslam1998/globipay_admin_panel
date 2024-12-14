// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryResponseEntity _$CategoryResponseEntityFromJson(
        Map<String, dynamic> json) =>
    CategoryResponseEntity(
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoryItemEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoryResponseEntityToJson(
        CategoryResponseEntity instance) =>
    <String, dynamic>{
      'categories': instance.categories,
      'pagination': instance.pagination,
    };
