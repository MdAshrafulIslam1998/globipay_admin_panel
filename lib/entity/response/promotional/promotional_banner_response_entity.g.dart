// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotional_banner_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromotionalBannerResponseEntity _$PromotionalBannerResponseEntityFromJson(
        Map<String, dynamic> json) =>
    PromotionalBannerResponseEntity(
      sliders: (json['sliders'] as List<dynamic>?)
          ?.map(
              (e) => PromotionalBannerItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PromotionalBannerResponseEntityToJson(
        PromotionalBannerResponseEntity instance) =>
    <String, dynamic>{
      'sliders': instance.sliders,
      'pagination': instance.pagination,
    };
