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
      message: json['message'] as String?,
      message_status: json['message_status'] as bool?,
    );

Map<String, dynamic> _$CategoryItemEntityToJson(CategoryItemEntity instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.image case final value?) 'image': value,
      if (instance.bgcolor case final value?) 'bgcolor': value,
      if (instance.message case final value?) 'message': value,
      if (instance.message_status case final value?) 'message_status': value,
    };
