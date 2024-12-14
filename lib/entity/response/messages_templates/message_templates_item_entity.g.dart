// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_templates_item_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageTemplatesItemEntity _$MessageTemplatesItemEntityFromJson(
        Map<String, dynamic> json) =>
    MessageTemplatesItemEntity(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      message: json['message'] as String?,
      category: json['category'] == null
          ? null
          : CategoryItemEntity.fromJson(
              json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageTemplatesItemEntityToJson(
        MessageTemplatesItemEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'message': instance.message,
      'category': instance.category,
    };
