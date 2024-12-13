// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_close_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatCloseResponseEntity _$ChatCloseResponseEntityFromJson(
        Map<String, dynamic> json) =>
    ChatCloseResponseEntity(
      catId: (json['catId'] as num?)?.toInt(),
      uid: json['uid'] as String?,
      primaryCoin: (json['primaryCoin'] as num?)?.toDouble(),
      secondaryCoin: (json['secondaryCoin'] as num?)?.toDouble(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      createdBy: json['createdBy'] as String?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$ChatCloseResponseEntityToJson(
        ChatCloseResponseEntity instance) =>
    <String, dynamic>{
      'catId': instance.catId,
      'uid': instance.uid,
      'primaryCoin': instance.primaryCoin,
      'secondaryCoin': instance.secondaryCoin,
      'name': instance.name,
      'email': instance.email,
      'createdBy': instance.createdBy,
      'date': instance.date,
    };
