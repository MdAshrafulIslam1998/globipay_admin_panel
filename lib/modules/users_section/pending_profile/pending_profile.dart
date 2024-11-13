
class ProfileData {
  final String email;
  final String fullName;
  final String phone;
  final String dob;
  final String gender;
  final String address;
  final int level;
  final String status;
  final String selfiePath;
  final String frontIdPath;
  final String backIdPath;

  ProfileData({
    required this.email,
    required this.fullName,
    required this.phone,
    required this.dob,
    required this.gender,
    required this.address,
    required this.level,
    required this.status,
    required this.selfiePath,
    required this.frontIdPath,
    required this.backIdPath,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      email: json['email'],
      fullName: json['full_name'],
      phone: json['phone'],
      dob: json['dob'],
      gender: json['gender'],
      address: json['address'],
      level: json['level'],
      status: json['status'],
      selfiePath: json['selfie_path'],
      frontIdPath: json['front_id_path'],
      backIdPath: json['back_id_path'],
    );
  }
}
