class PendingUser {
  final String userId;
  final String name;
  final String email;
  final String status;
  final DateTime date;

  PendingUser({
    required this.userId,
    required this.name,
    required this.email,
    required this.status,
    required this.date,
  });

  factory PendingUser.fromJson(Map<String, dynamic> json) {
    return PendingUser(
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
      status: json['status'],
      date: DateTime.parse(json['date']),
    );
  }
}
