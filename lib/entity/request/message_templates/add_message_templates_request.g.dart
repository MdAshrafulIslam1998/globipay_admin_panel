// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_message_templates_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddMessageTemplatesRequest _$AddMessageTemplatesRequestFromJson(
        Map<String, dynamic> json) =>
    AddMessageTemplatesRequest(
      title: json['title'] as String?,
      description: json['description'] as String?,
      categoryId: json['categoryId'] as String?,
      createdBy: json['createdBy'] as String?,
    );

Map<String, dynamic> _$AddMessageTemplatesRequestToJson(
        AddMessageTemplatesRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'categoryId': instance.categoryId,
      'createdBy': instance.createdBy,
    };
