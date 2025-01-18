// activity_log_item_entity.dart
import 'package:json_annotation/json_annotation.dart';

part 'activity_log_item_entity.g.dart';

@JsonSerializable()
class ActivityLogItemEntity {
  @JsonKey(name: "id")
  int? id;
  
  @JsonKey(name: "url")
  String? url;
  
  @JsonKey(name: "method")
  String? method;
  
  @JsonKey(name: "user_id")
  String? userId;
  
  @JsonKey(name: "status")
  String? status;
  
  @JsonKey(name: "created_at")
  String? createdAt;
  
  @JsonKey(name: "type")
  String? type;

  ActivityLogItemEntity({
    this.id,
    this.url,
    this.method,
    this.userId,
    this.status,
    this.createdAt,
    this.type,
  });

  factory ActivityLogItemEntity.fromJson(Map<String, dynamic> json) => 
      _$ActivityLogItemEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityLogItemEntityToJson(this);
}