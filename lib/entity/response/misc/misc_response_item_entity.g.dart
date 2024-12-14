// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'misc_response_item_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MiscResponseItemEntity _$MiscResponseItemEntityFromJson(
        Map<String, dynamic> json) =>
    MiscResponseItemEntity(
      id: json['id'] as String?,
      feature_code: json['feature_code'] as String?,
      type: json['type'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$MiscResponseItemEntityToJson(
        MiscResponseItemEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'feature_code': instance.feature_code,
      'type': instance.type,
      'content': instance.content,
    };
