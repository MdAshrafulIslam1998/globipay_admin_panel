import 'package:globipay_admin_panel/modules/users_section/pending_profile/pending_profile.dart';

class PendingProfileResponse {
  final String responseCode;
  final String responseMessage;
  final ProfileData data;

  PendingProfileResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.data,
  });

  factory PendingProfileResponse.fromJson(Map<String, dynamic> json) {
    return PendingProfileResponse(
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
      data: ProfileData.fromJson(json['data']),
    );
  }
}
