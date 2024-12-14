/**
 * Created by Abdullah on 14/12/24.
 */

class MiscellaneousItemModel {
  String? title;
  String? description;
  String? id;
  String? code;

  MiscellaneousItemModel({
    this.title,
    this.description,
    this.code,
    this.id,
  });

  factory MiscellaneousItemModel.fromJson(Map<String, dynamic> json) {
    return MiscellaneousItemModel(
      title: json['title'],
      description: json['description'],
      code: json['code'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'code': code,
      'id': id,
    };
  }
}