// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_misc_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddMiscRequestEntity _$AddMiscRequestEntityFromJson(
        Map<String, dynamic> json) =>
    AddMiscRequestEntity(
      featureCode: json['featureCode'] as String?,
      type: json['type'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$AddMiscRequestEntityToJson(
        AddMiscRequestEntity instance) =>
    <String, dynamic>{
      'featureCode': instance.featureCode,
      'type': instance.type,
      'content': instance.content,
    };
