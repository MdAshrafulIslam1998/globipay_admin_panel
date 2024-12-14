// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_message_templates_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddMessageTemplatesRequest _$AddMessageTemplatesRequestFromJson(
        Map<String, dynamic> json) =>
    AddMessageTemplatesRequest(
      title: json['title'] as String?,
      message: json['message'] as String?,
      category: json['category'] as String?,
    );

Map<String, dynamic> _$AddMessageTemplatesRequestToJson(
        AddMessageTemplatesRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'message': instance.message,
      'category': instance.category,
    };
