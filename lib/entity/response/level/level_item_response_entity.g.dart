// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_item_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LevelItemResponseEntity _$LevelItemResponseEntityFromJson(
        Map<String, dynamic> json) =>
    LevelItemResponseEntity(
      levelName: json['level_name'] as String?,
      levelValue: (json['level_value'] as num?)?.toInt(),
      minThresh: (json['min_thresh'] as num?)?.toDouble(),
      maxThresh: (json['max_thresh'] as num?)?.toDouble(),
      createdBy: json['created_by'] as String?,
      date: json['date'] as String?,
      levid: (json['levid'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LevelItemResponseEntityToJson(
        LevelItemResponseEntity instance) =>
    <String, dynamic>{
      'level_name': instance.levelName,
      'level_value': instance.levelValue,
      'min_thresh': instance.minThresh,
      'max_thresh': instance.maxThresh,
      'created_by': instance.createdBy,
      'date': instance.date,
      'levid': instance.levid,
    };
