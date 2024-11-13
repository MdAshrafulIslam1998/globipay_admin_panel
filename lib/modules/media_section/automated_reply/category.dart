class Category {
  final int id;
  final String name;
  final String image;
  final String createdBy;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.createdBy,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      createdBy: json['created_by'],
    );
  }
}
