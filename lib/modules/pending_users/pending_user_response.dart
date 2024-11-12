// pending_user_response.dart
import 'package:globipay_admin_panel/modules/pending_users/pending_user.dart';

class PendingUserResponse {
  String responseCode;
  String responseMessage;
  List<PendingUser> users;
  Pagination pagination;

  PendingUserResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.users,
    required this.pagination,
  });

  factory PendingUserResponse.fromJson(Map<String, dynamic> json) {
    return PendingUserResponse(
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
      users: (json['data']['users'] as List)
          .map((user) => PendingUser.fromJson(user))
          .toList(),
      pagination: Pagination.fromJson(json['data']['pagination']),
    );
  }
}

class Pagination {
  int total;
  int totalPages;
  int currentPage;
  int limit;

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