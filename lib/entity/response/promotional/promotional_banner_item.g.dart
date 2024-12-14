// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotional_banner_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromotionalBannerItem _$PromotionalBannerItemFromJson(
        Map<String, dynamic> json) =>
    PromotionalBannerItem(
      id: (json['id'] as num?)?.toInt(),
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

Map<String, dynamic> _$PromotionalBannerItemToJson(
        PromotionalBannerItem instance) =>
    <String, dynamic>{
      'id': instance.id,
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
