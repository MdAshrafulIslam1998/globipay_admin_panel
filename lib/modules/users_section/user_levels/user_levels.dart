class UserLevel {
  final String userId;
  final String name;
  final String email;
  final double primary;
  final double secondary;
  final int levelId;
  final String levelName;
  final String status;
  final DateTime date;

  UserLevel({
    required this.userId,
    required this.name,
    required this.email,
    required this.primary,
    required this.secondary,
    required this.levelId,
    required this.levelName,
    required this.status,
    required this.date,
  });

  factory UserLevel.fromJson(Map<String, dynamic> json) {
    return UserLevel(
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
      primary: json['primary'],
      secondary: json['secondary'],
      levelId: json['level_id'],
      levelName: json['level_name'],
      status: json['status'],
      date: DateTime.parse(json['date']),
    );
  }
}
