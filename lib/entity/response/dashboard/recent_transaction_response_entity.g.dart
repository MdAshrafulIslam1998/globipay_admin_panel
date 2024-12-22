// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_transaction_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentTransactionResponseEntity _$RecentTransactionResponseEntityFromJson(
        Map<String, dynamic> json) =>
    RecentTransactionResponseEntity(
      uid: json['uid'] as String?,
      name: json['name'] as String?,
      categoryName: json['category_name'] as String?,
      createdBy: json['created_by'] as String?,
      transactionDate: json['transaction_date'] as String?,
      primaryAmount: (json['primary_amount'] as num?)?.toDouble(),
      secondaryAmount: (json['secondary_amount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RecentTransactionResponseEntityToJson(
        RecentTransactionResponseEntity instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'category_name': instance.categoryName,
      'created_by': instance.createdBy,
      'transaction_date': instance.transactionDate,
      'primary_amount': instance.primaryAmount,
      'secondary_amount': instance.secondaryAmount,
    };
