// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_level_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddLevelRequestEntity _$AddLevelRequestEntityFromJson(
        Map<String, dynamic> json) =>
    AddLevelRequestEntity(
      levelName: json['level_name'] as String?,
      levelValue: (json['level_value'] as num?)?.toInt(),
      minThresh: (json['min_thresh'] as num?)?.toDouble(),
      maxThresh: (json['max_thresh'] as num?)?.toDouble(),
      createdBy: json['created_by'] as String?,
    );

Map<String, dynamic> _$AddLevelRequestEntityToJson(
        AddLevelRequestEntity instance) =>
    <String, dynamic>{
      'level_name': instance.levelName,
      'level_value': instance.levelValue,
      'min_thresh': instance.minThresh,
      'max_thresh': instance.maxThresh,
      'created_by': instance.createdBy,
    };
