// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_item_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryItemEntity _$CategoryItemEntityFromJson(Map<String, dynamic> json) =>
    CategoryItemEntity(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      image: json['image'] as String?,
      bgcolor: json['bgcolor'] as String?,
    );

Map<String, dynamic> _$CategoryItemEntityToJson(CategoryItemEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'bgcolor': instance.bgcolor,
    };
