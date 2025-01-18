// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileData _$UserProfileDataFromJson(Map<String, dynamic> json) =>
    UserProfileData(
      userCode: json['user_code'] as String?,
      userName: json['username'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      dob: json['dob'] as String?,
      gender: json['gender'] as String?,
      address: json['address'] as String?,
      level: (json['level'] as num?)?.toInt(),
      status: json['status'] as String?,
      selfiePath: json['selfie_path'] as String?,
      frontIdPath: json['front_id_path'] as String?,
      backIdPath: json['back_id_path'] as String?,
    );

Map<String, dynamic> _$UserProfileDataToJson(UserProfileData instance) =>
    <String, dynamic>{
      'user_code': instance.userCode,
      'username': instance.userName,
      'email': instance.email,
      'phone': instance.phone,
      'dob': instance.dob,
      'gender': instance.gender,
      'address': instance.address,
      'level': instance.level,
      'status': instance.status,
      'selfie_path': instance.selfiePath,
      'front_id_path': instance.frontIdPath,
      'back_id_path': instance.backIdPath,
    };
