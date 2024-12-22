// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_transaction_balance_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardTransactionBalanceEntity _$DashboardTransactionBalanceEntityFromJson(
        Map<String, dynamic> json) =>
    DashboardTransactionBalanceEntity(
      total_primary: (json['total_primary'] as num?)?.toDouble(),
      total_secondary: (json['total_secondary'] as num?)?.toDouble(),
      total_transactions: (json['total_transactions'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DashboardTransactionBalanceEntityToJson(
        DashboardTransactionBalanceEntity instance) =>
    <String, dynamic>{
      'total_primary': instance.total_primary,
      'total_secondary': instance.total_secondary,
      'total_transactions': instance.total_transactions,
    };
