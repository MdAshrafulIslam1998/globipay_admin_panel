// update_user_status_response.dart
import 'package:json_annotation/json_annotation.dart';

part 'update_user_status_response.g.dart';


@JsonSerializable()
class UserData {
  @JsonKey(name: "id")
  int? id;
  
  @JsonKey(name: "name")
  String? name;
  
  @JsonKey(name: "email")
  String? email;
  
  @JsonKey(name: "phone")
  String? phone;
  
  @JsonKey(name: "user_id")
  String? userId;
  
  @JsonKey(name: "status")
  String? status;
  
  // Add other fields as needed...

  UserData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.userId,
    this.status,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => 
      _$UserDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}