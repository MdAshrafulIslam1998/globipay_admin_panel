// activity_log_response_entity.dart
import 'package:json_annotation/json_annotation.dart';
import 'activity_log_item_entity.dart';
import 'package:globipay_admin_panel/entity/response/pagination/pagination.dart';

part 'activity_log_response_entity.g.dart';

@JsonSerializable()
class ActivityLogResponseEntity {
  @JsonKey(name: "activity_logs")
  List<ActivityLogItemEntity>? activityLogs;
  
  @JsonKey(name: "pagination")
  Pagination? pagination;

  ActivityLogResponseEntity({
    this.activityLogs,
    this.pagination,
  });

  factory ActivityLogResponseEntity.fromJson(Map<String, dynamic> json) => 
      _$ActivityLogResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityLogResponseEntityToJson(this);
}
