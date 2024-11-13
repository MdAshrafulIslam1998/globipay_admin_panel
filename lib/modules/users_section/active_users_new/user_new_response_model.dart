import 'package:globipay_admin_panel/modules/users_section/active_users_new/user_new.dart';

class UserResponse {
  final String responseCode;
  final String responseMessage;
  final List<User> users;
  final Pagination pagination;

  UserResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.users,
    required this.pagination,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
      users: (json['data']['users'] as List).map((user) => User.fromJson(user)).toList(),
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