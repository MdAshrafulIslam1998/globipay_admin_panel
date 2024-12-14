import 'package:json_annotation/json_annotation.dart';
/**
 * Created by Abdullah on 14/12/24.
 */

part 'misc_response_item_entity.g.dart';

@JsonSerializable()
class MiscResponseItemEntity {
  final int? service_id;
  final String? feature_code;
  final String? type;
  final String? content;


  MiscResponseItemEntity({
    this.service_id,
    this.feature_code,
    this.type,
    this.content,
  });

  factory MiscResponseItemEntity.fromJson(Map<String, dynamic> json) =>
      _$MiscResponseItemEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MiscResponseItemEntityToJson(this);
}