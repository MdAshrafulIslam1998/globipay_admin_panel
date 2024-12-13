// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_close_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatCloseRequestEntity _$ChatCloseRequestEntityFromJson(
        Map<String, dynamic> json) =>
    ChatCloseRequestEntity(
      catId: (json['catId'] as num?)?.toInt(),
      uid: json['uid'] as String?,
      primaryCoin: (json['primary_coin'] as num?)?.toDouble(),
      secondaryCoin: (json['secondary_coin'] as num?)?.toDouble(),
      createdBy: json['createdBy'] as String?,
    );

Map<String, dynamic> _$ChatCloseRequestEntityToJson(
        ChatCloseRequestEntity instance) =>
    <String, dynamic>{
      'catId': instance.catId,
      'uid': instance.uid,
      'primary_coin': instance.primaryCoin,
      'secondary_coin': instance.secondaryCoin,
      'createdBy': instance.createdBy,
    };
