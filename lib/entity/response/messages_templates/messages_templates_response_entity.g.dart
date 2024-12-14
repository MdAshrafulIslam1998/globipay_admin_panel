// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_templates_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessagesTemplatesResponseEntity _$MessagesTemplatesResponseEntityFromJson(
        Map<String, dynamic> json) =>
    MessagesTemplatesResponseEntity(
      templates: (json['templates'] as List<dynamic>)
          .map((e) =>
              MessageTemplatesItemEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessagesTemplatesResponseEntityToJson(
        MessagesTemplatesResponseEntity instance) =>
    <String, dynamic>{
      'templates': instance.templates,
      'pagination': instance.pagination,
    };
