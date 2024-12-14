// To parse this JSON data, do
//
//     final categoryCoinModelDart = categoryCoinModelDartFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'category_coin_model.g.dart';


@JsonSerializable()
class CategoryCoinModelDart {
    @JsonKey(name: "id")
    int? id;
    @JsonKey(name: "name")
    String? name;
    @JsonKey(name: "PRIMARY")
    int? primary;
    @JsonKey(name: "SECONDARY")
    int? secondary;

    CategoryCoinModelDart({
        this.id,
        this.name,
        this.primary,
        this.secondary,
    });

    factory CategoryCoinModelDart.fromJson(Map<String, dynamic> json) => _$CategoryCoinModelDartFromJson(json);

    Map<String, dynamic> toJson() => _$CategoryCoinModelDartToJson(this);
}
