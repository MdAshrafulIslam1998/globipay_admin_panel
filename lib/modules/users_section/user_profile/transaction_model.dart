/**
 * Created by Abdullah on 15/12/24.
 */
import 'package:intl/intl.dart';

class TransactionModel {
  final String id;
  final DateTime dateTime;
  final String type; // Primary or Secondary
  final String categoryName;
  final double amount;

  TransactionModel({
    required this.id,
    required this.dateTime,
    required this.type,
    required this.categoryName,
    required this.amount,
  });

  String get formattedDate => DateFormat('dd MMM yyyy HH:mm').format(dateTime);
  String get formattedAmount => NumberFormat.currency(symbol: '\$').format(amount);
}