import 'package:json_annotation/json_annotation.dart';
/**
 * Created by Abdullah on 13/10/24.
 */

part 'category_item_entity.g.dart';

@JsonSerializable()
class CategoryItemEntity {
  int? id;
  String? name;
  String? image;
  String? bgcolor;

  CategoryItemEntity({
     this.id,
     this.name,
     this.image,
     this.bgcolor,
  });

  factory CategoryItemEntity.fromJson(Map<String, dynamic> json) => _$CategoryItemEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryItemEntityToJson(this);
}