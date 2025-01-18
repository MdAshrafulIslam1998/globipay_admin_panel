// update_user_status_request.dart
import 'package:json_annotation/json_annotation.dart';

part 'update_user_status_request.g.dart';

@JsonSerializable()
class UpdateUserStatusRequest {
  @JsonKey(name: "status")
  String status;

  UpdateUserStatusRequest({
    required this.status,
  });

  factory UpdateUserStatusRequest.fromJson(Map<String, dynamic> json) => 
      _$UpdateUserStatusRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateUserStatusRequestToJson(this);
}