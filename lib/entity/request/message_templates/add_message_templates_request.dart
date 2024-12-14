/**
 * Created by Abdullah on 14/12/24.
 */

import 'package:json_annotation/json_annotation.dart';

part 'add_message_templates_request.g.dart';

@JsonSerializable()
class AddMessageTemplatesRequest {
  String? title;
  String? description;
  String? categoryId;
  String? createdBy;

  AddMessageTemplatesRequest({
    this.title,
    this.description,
    this.categoryId,
    this.createdBy,
  });


  factory AddMessageTemplatesRequest.fromJson(Map<String, dynamic> json) => _$AddMessageTemplatesRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddMessageTemplatesRequestToJson(this);
}