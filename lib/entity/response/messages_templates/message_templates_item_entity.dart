/**
 * Created by Abdullah on 14/12/24.
 */

import 'package:globipay_admin_panel/entity/response/category/category_item_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_templates_item_entity.g.dart';


@JsonSerializable()
class MessageTemplatesItemEntity {
  int? id;
  String? title;
  String? message;
  CategoryItemEntity? category;

  MessageTemplatesItemEntity({
    this.id,
    this.title,
    this.message,
    this.category,
  });

  factory MessageTemplatesItemEntity.fromJson(Map<String, dynamic> json) => _$MessageTemplatesItemEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MessageTemplatesItemEntityToJson(this);
}