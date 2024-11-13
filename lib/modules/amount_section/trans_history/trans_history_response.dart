// 3. transaction_response.dart
import 'package:globipay_admin_panel/modules/amount_section/trans_history/trans_history.dart';

class TransactionResponse {
  final String responseCode;
  final String responseMessage;
  final List<Transaction> transactions;
  final Pagination pagination;

  TransactionResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.transactions,
    required this.pagination,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
      transactions: (json['data']['transactions'] as List)
          .map((transaction) => Transaction.fromJson(transaction))
          .toList(),
      pagination: Pagination.fromJson(json['data']['pagination']),
    );
  }
}

class Pagination {
  final int total;
  final int totalPages;
  final int currentPage;
  final int limit;

  Pagination({
    required this.total,
    required this.totalPages,
    required this.currentPage,
    required this.limit,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      total: json['total'],
      totalPages: json['total_pages'],
      currentPage: json['current_page'],
      limit: json['limit'],
    );
  }
}