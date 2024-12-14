import 'package:json_annotation/json_annotation.dart';
import '../pagination/pagination.dart';
import 'category_item_entity.dart';
/**
 * Created by Abdullah on 13/10/24.
 */
part 'category_response.g.dart';
@JsonSerializable()
class CategoryResponseEntity{
  List<CategoryItemEntity>? categories;
  Pagination? pagination;

CategoryResponseEntity({
    this.categories,
    this.pagination,
  });

  factory CategoryResponseEntity.fromJson(Map<String, dynamic> json) => _$CategoryResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseEntityToJson(this);

}