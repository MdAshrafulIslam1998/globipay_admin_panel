import 'package:globipay_admin_panel/entity/response/category/category_item_entity.dart';
import 'package:json_annotation/json_annotation.dart';
/**
 * Created by Abdullah on 16/12/24.
 */
part 'user_transaction_history_item_response.g.dart';

@JsonSerializable()
class UserTransactionHistoryResponseItem {
  int? id;
  CategoryItemEntity? category;
  int? coin;
  String? date;
  String? name;
  String? email;
  String? createdBy;
  String? coin_type;

  UserTransactionHistoryResponseItem({
    this.id,
    this.category,
    this.coin,
    this.date,
    this.name,
    this.email,
    this.createdBy,
    this.coin_type,
  });

  factory UserTransactionHistoryResponseItem.fromJson(Map<String, dynamic> json) => _$UserTransactionHistoryResponseItemFromJson(json);

  Map<String, dynamic> toJson() => _$UserTransactionHistoryResponseItemToJson(this);
}