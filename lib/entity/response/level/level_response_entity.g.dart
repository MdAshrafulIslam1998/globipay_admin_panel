// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LevelResponseEntity _$LevelResponseEntityFromJson(Map<String, dynamic> json) =>
    LevelResponseEntity(
      levels: (json['levels'] as List<dynamic>?)
          ?.map((e) =>
              LevelItemResponseEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LevelResponseEntityToJson(
        LevelResponseEntity instance) =>
    <String, dynamic>{
      'levels': instance.levels,
    };
