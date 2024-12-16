import 'package:json_annotation/json_annotation.dart';
/**
 * Created by Abdullah on 16/12/24.
 */

part 'notification_response_item_entity.g.dart';

@JsonSerializable()
class NotificationResponseItemEntity {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "notification_id")
  int? notificationId;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "details")
  String? details;
  @JsonKey(name: "rich_media_url")
  String? richMediaUrl;
  @JsonKey(name: "deep_link")
  String? deepLink;
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "time")
  String? time;
  @JsonKey(name: "days_of_week")
  dynamic daysOfWeek;
  @JsonKey(name: "start_date")
  dynamic startDate;
  @JsonKey(name: "interval_minutes")
  dynamic intervalMinutes;
  @JsonKey(name: "last_sent_at")
  String? lastSentAt;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "target_id")
  String? targetId;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "targetType")
  String? targetType;

  NotificationResponseItemEntity({
    this.id,
    this.notificationId,
    this.title,
    this.details,
    this.richMediaUrl,
    this.deepLink,
    this.type,
    this.time,
    this.daysOfWeek,
    this.startDate,
    this.intervalMinutes,
    this.lastSentAt,
    this.status,
    this.targetId,
    this.createdAt,
    this.updatedAt,
    this.targetType,
  });

  factory NotificationResponseItemEntity.fromJson(Map<String, dynamic> json) => _$NotificationResponseItemEntityFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationResponseItemEntityToJson(this);
}