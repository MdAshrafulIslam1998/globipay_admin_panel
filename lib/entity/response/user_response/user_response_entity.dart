import 'package:globipay_admin_panel/entity/response/user_response/user_response_item_entity.dart';
import 'package:globipay_admin_panel/entity/response/pagination/pagination.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

/**
 * Created by Abdullah on 8/12/24.
 */

part 'user_response_entity.g.dart';

@JsonSerializable()
class UserResponseEntity {
  @JsonKey(name: "users")
  List<UserResponseItemEntity>? users;
  @JsonKey(name: "pagination")
  Pagination? pagination;

  UserResponseEntity({
    this.users,
    this.pagination,
  });

  factory UserResponseEntity.fromJson(Map<String, dynamic> json) => _$UserResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseEntityToJson(this);
}