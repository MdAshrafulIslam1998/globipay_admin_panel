/// Created by Abdullah on 21/12/24.
library;

import 'package:globipay_admin_panel/entity/response/notification/notification_response_item_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'notification_response_entity.g.dart';

@JsonSerializable()
class NotificationResponseEntity {
  @JsonKey(name: "notifications")
  List<NotificationResponseItemEntity>? notifications;

  NotificationResponseEntity({
    this.notifications,
  });

  factory NotificationResponseEntity.fromJson(Map<String, dynamic> json) => _$NotificationResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationResponseEntityToJson(this);
}
