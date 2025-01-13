/// Created by Abdullah on 14/12/24.
library;

import 'package:globipay_admin_panel/entity/response/category/category_item_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_templates_item_entity.g.dart';


@JsonSerializable()
class MessageTemplatesItemEntity {
  String? uid;
  String? title;
  String? description;
  String? category_name;
  String? create_date;
  int? category_id;

  MessageTemplatesItemEntity({
    this.uid,
    this.title,
    this.description,
    this.category_name,
    this.category_id,
    this.create_date,
  });

  factory MessageTemplatesItemEntity.fromJson(Map<String, dynamic> json) => _$MessageTemplatesItemEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MessageTemplatesItemEntityToJson(this);
}