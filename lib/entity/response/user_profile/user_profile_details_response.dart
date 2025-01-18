import 'package:json_annotation/json_annotation.dart';

part 'user_profile_details_response.g.dart';


@JsonSerializable()
class UserProfileData {
  @JsonKey(name: "user_code")
  String? userCode;

  @JsonKey(name: "username")
  String? userName;
  
  @JsonKey(name: "email")
  String? email;
  
  @JsonKey(name: "phone")
  String? phone;
  
  @JsonKey(name: "dob")
  String? dob;
  
  @JsonKey(name: "gender")
  String? gender;
  
  @JsonKey(name: "address")
  String? address;
  
  @JsonKey(name: "level")
  int? level;
  
  @JsonKey(name: "status")
  String? status;
  
  @JsonKey(name: "selfie_path")
  String? selfiePath;
  
  @JsonKey(name: "front_id_path")
  String? frontIdPath;
  
  @JsonKey(name: "back_id_path")
  String? backIdPath;

  UserProfileData({
    this.userCode,
    this.userName,
    this.email,
    this.phone,
    this.dob,
    this.gender,
    this.address,
    this.level,
    this.status,
    this.selfiePath,
    this.frontIdPath,
    this.backIdPath,
  });

  factory UserProfileData.fromJson(Map<String, dynamic> json) => 
      _$UserProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileDataToJson(this);
}