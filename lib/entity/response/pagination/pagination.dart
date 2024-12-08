import 'package:json_annotation/json_annotation.dart';

/**
 * Created by Abdullah on 8/12/24.
 */

part 'pagination.g.dart';

@JsonSerializable()
class Pagination {
  @JsonKey(name: "total")
  int? total;
  @JsonKey(name: "total_pages")
  int? totalPages;
  @JsonKey(name: "current_page")
  int? currentPage;
  @JsonKey(name: "limit")
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
