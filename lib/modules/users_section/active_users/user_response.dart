import 'package:globipay_admin_panel/modules/users_section/active_users/user.dart';

/**
 * Created by Abdullah on 10/11/24.
 */

class UserResponse {
  String responseCode;
  String responseMessage;
  List<User> users;
  Pagination pagination;

  UserResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.users,
    required this.pagination,
  });

  // Factory constructor to parse JSON
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

  // Factory constructor to parse JSON
  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      total: json['total'],
      totalPages: json['total_pages'],
      currentPage: json['current_page'],
      limit: json['limit'],
    );
  }
}
