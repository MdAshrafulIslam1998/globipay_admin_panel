

import 'package:globipay_admin_panel/modules/users_section/user_levels/user_levels.dart';

class UserLevelResponse {
  String responseCode;
  String responseMessage;
  List<UserLevel> users;
  Pagination pagination;

  UserLevelResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.users,
    required this.pagination,
  });

  factory UserLevelResponse.fromJson(Map<String, dynamic> json) {
    return UserLevelResponse(
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
      users: (json['data']['users'] as List)
          .map((user) => UserLevel.fromJson(user))
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
