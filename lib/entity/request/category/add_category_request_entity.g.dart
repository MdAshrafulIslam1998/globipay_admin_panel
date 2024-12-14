// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_category_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCategoryRequestEntity _$AddCategoryRequestEntityFromJson(
        Map<String, dynamic> json) =>
    AddCategoryRequestEntity(
      name: json['name'] as String?,
      image: json['image'] as String?,
      createdBy: json['created_by'] as String?,
      bgcolor: json['bgcolor'] as String?,
    );

Map<String, dynamic> _$AddCategoryRequestEntityToJson(
        AddCategoryRequestEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'created_by': instance.createdBy,
      'bgcolor': instance.bgcolor,
    };
