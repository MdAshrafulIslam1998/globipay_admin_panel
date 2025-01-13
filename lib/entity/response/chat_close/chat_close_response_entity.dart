import 'package:json_annotation/json_annotation.dart';

/**
 * Created by Abdullah on 13/12/24.
 */

part 'chat_close_response_entity.g.dart';

@JsonSerializable()
class ChatCloseResponseEntity {
  @JsonKey(name: "catId")
  int? catId;
  @JsonKey(name: "uid")
  String? uid;
  @JsonKey(name: "primaryCoin")
  double? primaryCoin;
  @JsonKey(name: "secondaryCoin")
  double? secondaryCoin;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "createdBy")
  String? createdBy;
  @JsonKey(name: "date")
  String? date;

  ChatCloseResponseEntity({
    this.catId,
    this.uid,
    this.primaryCoin,
    this.secondaryCoin,
    this.name,
    this.email,
    this.createdBy,
    this.date,
  });

  factory ChatCloseResponseEntity.fromJson(Map<String, dynamic> json) => _$ChatCloseResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ChatCloseResponseEntityToJson(this);
}
