// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_coin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryCoinModelDart _$CategoryCoinModelDartFromJson(
        Map<String, dynamic> json) =>
    CategoryCoinModelDart(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      primary: (json['PRIMARY'] as num?)?.toInt(),
      secondary: (json['SECONDARY'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CategoryCoinModelDartToJson(
        CategoryCoinModelDart instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'PRIMARY': instance.primary,
      'SECONDARY': instance.secondary,
    };
