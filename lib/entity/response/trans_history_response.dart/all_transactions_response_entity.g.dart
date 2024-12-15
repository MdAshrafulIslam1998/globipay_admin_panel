// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_transactions_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllTransactionsResponseEntity _$AllTransactionsResponseEntityFromJson(
        Map<String, dynamic> json) =>
    AllTransactionsResponseEntity(
      transactions: (json['transactions'] as List<dynamic>?)
          ?.map(
              (e) => TransactionItemEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AllTransactionsResponseEntityToJson(
        AllTransactionsResponseEntity instance) =>
    <String, dynamic>{
      'transactions': instance.transactions,
      'pagination': instance.pagination,
    };
