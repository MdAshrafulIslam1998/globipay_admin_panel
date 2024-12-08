// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponseEntity _$UserResponseEntityFromJson(Map<String, dynamic> json) =>
    UserResponseEntity(
      users: (json['users'] as List<dynamic>?)
          ?.map(
              (e) => UserResponseItemEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserResponseEntityToJson(UserResponseEntity instance) =>
    <String, dynamic>{
      'users': instance.users,
      'pagination': instance.pagination,
    };
