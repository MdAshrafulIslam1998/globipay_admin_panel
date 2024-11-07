class CoinData {
  final String userId;
  final String fullName;
  final String email;
  final List<String> amount;
  final String level;
  final String status;

  CoinData({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.amount,
    required this.level,
    required this.status,
  });
}