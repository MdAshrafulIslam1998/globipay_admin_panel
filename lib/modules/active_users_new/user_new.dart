class User {
  final String userId;
  final String name;
  final String email;
  final double amount;
  final int levelId;
  final String levelName;
  final String status;
  final DateTime date;

  User({
    required this.userId,
    required this.name,
    required this.email,
    required this.amount,
    required this.levelId,
    required this.levelName,
    required this.status,
    required this.date,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
      amount: json['amount'],
      levelId: json['level_id'],
      levelName: json['level_name'],
      status: json['status'],
      date: DateTime.parse(json['date']),
    );
  }
}