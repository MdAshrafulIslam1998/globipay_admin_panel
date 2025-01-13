import 'package:json_annotation/json_annotation.dart';

/**
 * Created by Abdullah on 21/12/24.
 */

part 'user_specific_notification_request.g.dart';

@JsonSerializable()
class UserSpecificNotificationRequest{
  String? target_id;

  UserSpecificNotificationRequest({
    this.target_id,
  });

  factory UserSpecificNotificationRequest.fromJson(Map<String, dynamic> json) => _$UserSpecificNotificationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserSpecificNotificationRequestToJson(this);

}