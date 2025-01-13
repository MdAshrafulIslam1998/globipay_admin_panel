import 'package:json_annotation/json_annotation.dart';
/**
 * Created by Abdullah on 22/12/24.
 */
part 'dashboard_transaction_balance_entity.g.dart';

@JsonSerializable()
class DashboardTransactionBalanceEntity {
  double? total_primary;
  double? total_secondary;
  double? total_transactions;

  DashboardTransactionBalanceEntity({
    this.total_primary,
    this.total_secondary,
    this.total_transactions,
  });

  factory DashboardTransactionBalanceEntity.fromJson(Map<String, dynamic> json) => _$DashboardTransactionBalanceEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardTransactionBalanceEntityToJson(this);
}
