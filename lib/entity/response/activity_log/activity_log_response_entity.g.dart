// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_log_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityLogResponseEntity _$ActivityLogResponseEntityFromJson(
        Map<String, dynamic> json) =>
    ActivityLogResponseEntity(
      activityLogs: (json['activity_logs'] as List<dynamic>?)
          ?.map(
              (e) => ActivityLogItemEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ActivityLogResponseEntityToJson(
        ActivityLogResponseEntity instance) =>
    <String, dynamic>{
      'activity_logs': instance.activityLogs,
      'pagination': instance.pagination,
    };
