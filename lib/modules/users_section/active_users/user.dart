/**
 * Created by Abdullah on 10/11/24.
 */
class User {
  final int id;
  final String name;
  final String designation;
  final int age;

  User({required this.id, required this.name, required this.designation, required this.age});

  // Factory method to create an instance from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      designation: json['designation'],
      age: json['age'],
    );
  }
}
