// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_transaction_history_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTransactionHistoryResponseItem _$UserTransactionHistoryResponseItemFromJson(
        Map<String, dynamic> json) =>
    UserTransactionHistoryResponseItem(
      id: (json['id'] as num?)?.toInt(),
      category: json['category'] == null
          ? null
          : CategoryItemEntity.fromJson(
              json['category'] as Map<String, dynamic>),
      coin: (json['coin'] as num?)?.toInt(),
      date: json['date'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      createdBy: json['createdBy'] as String?,
      coin_type: json['coin_type'] as String?,
    );

Map<String, dynamic> _$UserTransactionHistoryResponseItemToJson(
        UserTransactionHistoryResponseItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'coin': instance.coin,
      'date': instance.date,
      'name': instance.name,
      'email': instance.email,
      'createdBy': instance.createdBy,
      'coin_type': instance.coin_type,
    };
