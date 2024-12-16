// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_transaction_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTransactionHistoryResponseEntity
    _$UserTransactionHistoryResponseEntityFromJson(Map<String, dynamic> json) =>
        UserTransactionHistoryResponseEntity(
          transactions: (json['transactions'] as List<dynamic>?)
              ?.map((e) => UserTransactionHistoryResponseItem.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          pagination: json['pagination'] == null
              ? null
              : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$UserTransactionHistoryResponseEntityToJson(
        UserTransactionHistoryResponseEntity instance) =>
    <String, dynamic>{
      'transactions': instance.transactions,
      'pagination': instance.pagination,
    };
