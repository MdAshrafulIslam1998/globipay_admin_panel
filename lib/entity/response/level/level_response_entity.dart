import 'package:globipay_admin_panel/entity/response/level/level_item_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';
/**
* Created by Abdullah on 15/12/24
  */

part 'level_response_entity.g.dart';

@JsonSerializable()
class LevelResponseEntity {

  List<LevelItemResponseEntity>? levels;

  LevelResponseEntity({ this.levels});

  factory LevelResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$LevelResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LevelResponseEntityToJson(this);
}
