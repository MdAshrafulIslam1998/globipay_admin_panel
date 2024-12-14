/**
 * Created by Abdullah on 14/12/24.
 */

import 'package:json_annotation/json_annotation.dart';

part 'add_message_templates_request.g.dart';

@JsonSerializable()
class AddMessageTemplatesRequest {
  String? title;
  String? message;
  String? category;

  AddMessageTemplatesRequest({
    this.title,
    this.message,
    this.category,
  });

  factory AddMessageTemplatesRequest.fromJson(Map<String, dynamic> json) => _$AddMessageTemplatesRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddMessageTemplatesRequestToJson(this);
}