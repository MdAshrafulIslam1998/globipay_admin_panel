/**
 * Created by Abdullah on 14/12/24.
 */

import 'package:globipay_admin_panel/entity/response/messages_templates/message_templates_item_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import '../pagination/pagination.dart';

part 'messages_templates_response_entity.g.dart';

@JsonSerializable()

class MessagesTemplatesResponseEntity {

  @JsonKey(name: "templates")
  List<MessageTemplatesItemEntity> templates;
  @JsonKey(name: "pagination")
  Pagination? pagination;

  MessagesTemplatesResponseEntity({
    required this.templates,
    this.pagination,
  });

  factory MessagesTemplatesResponseEntity.fromJson(Map<String, dynamic> json) => _$MessagesTemplatesResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MessagesTemplatesResponseEntityToJson(this);
}