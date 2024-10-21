import 'package:json_annotation/json_annotation.dart';
/**
 * Created by Abdullah on 13/10/24.
 */
part 'pagination_request.g.dart';
@JsonSerializable()
class PaginationRequest {
  int? limit;
  int? page;


  PaginationRequest({
    this.page,
    this.limit,
  });

  factory PaginationRequest.fromJson(Map<String, dynamic> json) => _$PaginationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationRequestToJson(this);
}