import 'package:globipay_admin_panel/entity/response/user_transaction_history/user_transaction_history_item_response.dart';
import 'package:json_annotation/json_annotation.dart';

import '../pagination/pagination.dart';
/**
 * Created by Abdullah on 16/12/24.
 */

part 'user_transaction_history_response.g.dart';

@JsonSerializable()
class UserTransactionHistoryResponseEntity{
  List<UserTransactionHistoryResponseItem>? transactions;
  Pagination? pagination;

  UserTransactionHistoryResponseEntity({
    this.transactions,
    this.pagination,
  });

  factory UserTransactionHistoryResponseEntity.fromJson(Map<String, dynamic> json) => _$UserTransactionHistoryResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserTransactionHistoryResponseEntityToJson(this);

}