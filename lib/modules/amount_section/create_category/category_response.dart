// category_response.dart
import 'package:globipay_admin_panel/modules/amount_section/create_category/category.dart';

class CategoryResponse {
  final String responseCode;
  final String responseMessage;
  final List<Category> categories;
  final Pagination pagination;

  CategoryResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.categories,
    required this.pagination,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
      categories: (json['data']['categories'] as List)
          .map((category) => Category.fromJson(category))
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