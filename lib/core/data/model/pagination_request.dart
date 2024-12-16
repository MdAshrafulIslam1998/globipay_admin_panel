import 'package:json_annotation/json_annotation.dart';
/**
 * Created by Abdullah on 13/10/24.
 */
part 'pagination_request.g.dart';
@JsonSerializable(includeIfNull: false)
class PaginationRequest {
  int? limit;
  int? page;
  int? category;
  String? query;


  PaginationRequest({
    this.page,
    this.limit,
    this.category,
    this.query,
  });

  factory PaginationRequest.fromJson(Map<String, dynamic> json) => _$PaginationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationRequestToJson(this);
}