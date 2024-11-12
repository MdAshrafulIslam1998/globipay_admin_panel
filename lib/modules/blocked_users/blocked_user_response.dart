// blocked_user_response.dart
import 'package:globipay_admin_panel/modules/blocked_users/blocked_user.dart';

class BlockedUserResponse {
  String responseCode;
  String responseMessage;
  List<BlockedUser> users;
  Pagination pagination;

  BlockedUserResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.users,
    required this.pagination,
  });

  factory BlockedUserResponse.fromJson(Map<String, dynamic> json) {
    return BlockedUserResponse(
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
      users: (json['data']['users'] as List)
          .map((user) => BlockedUser.fromJson(user))
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
