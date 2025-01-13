/// Created by Abdullah on 14/12/24.
library;

import 'package:globipay_admin_panel/entity/response/misc/misc_response_item_entity.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_item_entity.dart';
import 'package:globipay_admin_panel/entity/response/pagination/pagination.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

/**
 * Created by Abdullah on 8/12/24.
 */

part 'misc_response_entity.g.dart';

@JsonSerializable()
class MiscResponseEntity {
  @JsonKey(name: "services")
  List<MiscResponseItemEntity>? services;
  @JsonKey(name: "pagination")
  Pagination? pagination;

  MiscResponseEntity({
    this.services,
    this.pagination,
  });

  factory MiscResponseEntity.fromJson(Map<String, dynamic> json) => _$MiscResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MiscResponseEntityToJson(this);
}