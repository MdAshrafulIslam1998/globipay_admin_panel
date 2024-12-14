// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_promotional_banner_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddPromotionalBannerRequestEntity _$AddPromotionalBannerRequestEntityFromJson(
        Map<String, dynamic> json) =>
    AddPromotionalBannerRequestEntity(
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      createdBy: json['created_by'] as String?,
      sendType: json['send_type'] as String?,
      sendTo: json['send_to'],
      action: json['action'] as String?,
      fromDate: json['from_date'] as String?,
      toDate: json['to_date'] as String?,
      sliderIndex: (json['slider_index'] as num?)?.toInt(),
      picture: json['picture'] as String?,
      bgColor: json['bgColor'] as String?,
    );

Map<String, dynamic> _$AddPromotionalBannerRequestEntityToJson(
        AddPromotionalBannerRequestEntity instance) =>
    <String, dynamic>{
      'title': instance.title,
      'subtitle': instance.subtitle,
      'created_by': instance.createdBy,
      'send_type': instance.sendType,
      'send_to': instance.sendTo,
      'action': instance.action,
      'from_date': instance.fromDate,
      'to_date': instance.toDate,
      'slider_index': instance.sliderIndex,
      'picture': instance.picture,
      'bgColor': instance.bgColor,
    };
