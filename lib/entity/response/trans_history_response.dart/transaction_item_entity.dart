import 'package:json_annotation/json_annotation.dart';

part 'transaction_item_entity.g.dart';

@JsonSerializable()
class TransactionItemEntity {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "cat_id")
  int? catId;

  @JsonKey(name: "uid")
  String? uid;

  @JsonKey(name: "coin")
  int? coin;

  @JsonKey(name: "date")
  String? date;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "created_by")
  String? createdBy;

  @JsonKey(name: "coin_type")
  String? coinType;

  @JsonKey(name: "category_name")
  String? categoryName;

  TransactionItemEntity({
    this.id,
    this.catId,
    this.uid,
    this.coin,
    this.date,
    this.name,
    this.email,
    this.createdBy,
    this.coinType,
    this.categoryName,
  });

  factory TransactionItemEntity.fromJson(Map<String, dynamic> json) =>
      _$TransactionItemEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionItemEntityToJson(this);
}
