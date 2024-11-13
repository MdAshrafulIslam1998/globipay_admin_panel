class UserAmount {
  final String userId;
  final String name;
  final String email;
  final String status;
  final Map<String, Map<String, int>> amount;

  UserAmount({
    required this.userId,
    required this.name,
    required this.email,
    required this.status,
    required this.amount,
  });

  factory UserAmount.fromJson(Map<String, dynamic> json) {
    return UserAmount(
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
      status: json['status'],
      amount: Map<String, Map<String, int>>.from(
        (json['amount'] as Map).map((key, value) => MapEntry(
          key,
          Map<String, int>.from(value),
        )),
      ),
    );
  }
}
