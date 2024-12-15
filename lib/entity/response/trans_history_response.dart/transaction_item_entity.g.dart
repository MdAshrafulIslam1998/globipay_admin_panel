// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_item_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionItemEntity _$TransactionItemEntityFromJson(
        Map<String, dynamic> json) =>
    TransactionItemEntity(
      id: (json['id'] as num?)?.toInt(),
      catId: (json['cat_id'] as num?)?.toInt(),
      uid: json['uid'] as String?,
      coin: (json['coin'] as num?)?.toInt(),
      date: json['date'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      createdBy: json['created_by'] as String?,
      coinType: json['coin_type'] as String?,
      categoryName: json['category_name'] as String?,
    );

Map<String, dynamic> _$TransactionItemEntityToJson(
        TransactionItemEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cat_id': instance.catId,
      'uid': instance.uid,
      'coin': instance.coin,
      'date': instance.date,
      'name': instance.name,
      'email': instance.email,
      'created_by': instance.createdBy,
      'coin_type': instance.coinType,
      'category_name': instance.categoryName,
    };
