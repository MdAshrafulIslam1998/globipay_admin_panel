
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
/**
 * Created by Abdullah on 22/12/24.
 */

part 'recent_transaction_response_entity.g.dart';

RecentTransactionResponseEntity recentTransactionResponseEntityFromJson(String str) => RecentTransactionResponseEntity.fromJson(json.decode(str));

String recentTransactionResponseEntityToJson(RecentTransactionResponseEntity data) => json.encode(data.toJson());

@JsonSerializable()
class RecentTransactionResponseEntity {
  @JsonKey(name: "uid")
  String? uid;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "category_name")
  String? categoryName;
  @JsonKey(name: "created_by")
  String? createdBy;
  @JsonKey(name: "transaction_date")
  String? transactionDate;
  @JsonKey(name: "primary_amount")
  double? primaryAmount;
  @JsonKey(name: "secondary_amount")
  double? secondaryAmount;

  RecentTransactionResponseEntity({
    this.uid,
    this.name,
    this.categoryName,
    this.createdBy,
    this.transactionDate,
    this.primaryAmount,
    this.secondaryAmount,
  });

  factory RecentTransactionResponseEntity.fromJson(Map<String, dynamic> json) => _$RecentTransactionResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RecentTransactionResponseEntityToJson(this);
}
