// 2. transaction.dart
class Transaction {
  final int id;
  final int catId;
  final String categoryName;
  final String uid;
  final int coin;
  final DateTime date;
  final String name;
  final String email;
  final String createdBy;
  final String coinType;

  Transaction({
    required this.id,
    required this.catId,
    required this.categoryName,
    required this.uid,
    required this.coin,
    required this.date,
    required this.name,
    required this.email,
    required this.createdBy,
    required this.coinType,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      catId: json['cat_id'],
      categoryName: json['catagory_name'],
      uid: json['uid'],
      coin: json['coin'],
      date: DateTime.parse(json['date']),
      name: json['name'],
      email: json['email'],
      createdBy: json['created_by'],
      coinType: json['coin_type'],
    );
  }
}
