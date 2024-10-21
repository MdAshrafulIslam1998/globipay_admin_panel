import 'package:json_annotation/json_annotation.dart';
/**
 * Created by Abdullah on 13/10/24.
 */

part 'pagination.g.dart';
@JsonSerializable()
class Pagination {
  int? total;
  int? totalPages;
  int? currentPage;
  int? limit;

  Pagination({
     this.total,
     this.totalPages,
     this.currentPage,
     this.limit,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}