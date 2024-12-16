// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationRequest _$PaginationRequestFromJson(Map<String, dynamic> json) =>
    PaginationRequest(
      page: (json['page'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
      category: (json['category'] as num?)?.toInt(),
      query: json['query'] as String?,
    );

Map<String, dynamic> _$PaginationRequestToJson(PaginationRequest instance) =>
    <String, dynamic>{
      if (instance.limit case final value?) 'limit': value,
      if (instance.page case final value?) 'page': value,
      if (instance.category case final value?) 'category': value,
      if (instance.query case final value?) 'query': value,
    };
