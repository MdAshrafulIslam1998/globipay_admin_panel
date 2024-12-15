import 'package:globipay_admin_panel/entity/response/pagination/pagination.dart';
import 'package:globipay_admin_panel/entity/response/trans_history_response.dart/transaction_item_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'all_transactions_response_entity.g.dart';

@JsonSerializable()
class AllTransactionsResponseEntity {
  @JsonKey(name: "transactions")
  List<TransactionItemEntity>? transactions;

  @JsonKey(name: "pagination")
  Pagination? pagination;

  AllTransactionsResponseEntity({
    this.transactions,
    this.pagination,
  });

  factory AllTransactionsResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$AllTransactionsResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AllTransactionsResponseEntityToJson(this);
}
