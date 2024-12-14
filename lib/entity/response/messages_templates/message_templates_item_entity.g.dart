// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_templates_item_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageTemplatesItemEntity _$MessageTemplatesItemEntityFromJson(
        Map<String, dynamic> json) =>
    MessageTemplatesItemEntity(
      uid: json['uid'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      category_name: json['category_name'] as String?,
      category_id: (json['category_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MessageTemplatesItemEntityToJson(
        MessageTemplatesItemEntity instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'title': instance.title,
      'description': instance.description,
      'category_name': instance.category_name,
      'category_id': instance.category_id,
    };
