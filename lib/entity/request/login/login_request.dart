import 'package:json_annotation/json_annotation.dart';
/**
 * Created by Abdullah on 8/12/24.
 */

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  String? email;
  String? password;

  LoginRequest({this.email, this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}