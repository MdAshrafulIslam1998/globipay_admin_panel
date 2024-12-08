import 'package:json_annotation/json_annotation.dart';

/**
 * Created by Abdullah on 8/12/24.
 */

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  String? token;
  int? role;
  String? stuff_id;

  LoginResponse({this.token, this.role, this.stuff_id});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
