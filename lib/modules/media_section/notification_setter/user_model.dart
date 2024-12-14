import 'package:uuid/uuid.dart';

enum NotificationTargetType { all, specific }

class NotificationModel {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final NotificationTargetType targetType;
  final List<String>? specificUserIds;
  final DateTime createdAt;
  final DateTime? scheduledFor;

  NotificationModel({
    String? id,
    required this.title,
    required this.description,
    this.imageUrl,
    this.targetType = NotificationTargetType.all,
    this.specificUserIds,
    DateTime? createdAt,
    this.scheduledFor,
  }) :
        id = id ?? Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'imageUrl': imageUrl,
    'targetType': targetType.toString().split('.').last,
    'specificUserIds': specificUserIds,
    'createdAt': createdAt.toIso8601String(),
    'scheduledFor': scheduledFor?.toIso8601String(),
  };

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      targetType: NotificationTargetType.values.firstWhere(
              (e) => e.toString().split('.').last == json['targetType']
      ),
      specificUserIds: json['specificUserIds'] != null
          ? List<String>.from(json['specificUserIds'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      scheduledFor: json['scheduledFor'] != null
          ? DateTime.parse(json['scheduledFor'])
          : null,
    );
  }
}

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? profilePicture;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.profilePicture,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'profilePicture': profilePicture,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profilePicture: json['profilePicture'],
    );
  }
}