import 'package:json_annotation/json_annotation.dart';

/**
 * Created by Abdullah on 8/12/24.
 */

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  String? token;
  int? role;
  String? staff_id;
  String? name;

  LoginResponse({this.token, this.role, this.staff_id, this.name});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
