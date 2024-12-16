import 'package:json_annotation/json_annotation.dart';
/**
 * Created by Abdullah on 8/12/24.
 */

part 'user_response_item_entity.g.dart';

@JsonSerializable()
class UserResponseItemEntity {
  @JsonKey(name: "user_id")
  String? userId;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "level_id")
  int? levelId;
  @JsonKey(name: "level_name")
  String? levelName;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "date")
  String? date;
  @JsonKey(name: "primary")
  double? primary;
  @JsonKey(name: "secondary")
  double? secondary;

  @JsonKey(name: "push_token")
  String? pushToken;



  UserResponseItemEntity({
    this.userId,
    this.name,
    this.email,
    this.phone,
    this.levelId,
    this.levelName,
    this.status,
    this.date,
    this.primary,
    this.secondary,
    this.pushToken,
  });

  factory UserResponseItemEntity.fromJson(Map<String, dynamic> json) => _$UserResponseItemEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseItemEntityToJson(this);
}
