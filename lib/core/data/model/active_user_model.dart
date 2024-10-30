import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/cell_button_model.dart';

class ActiveUserModel {
  final int id;
  final String name;
  final String email;
  final String status;
  final DateTime lastActive;
  final String role;
  final int activityCount;

  ActiveUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.status,
    required this.lastActive,
    required this.role,
    required this.activityCount,
  });

  Map<String, dynamic> toMap({
    required Function(int id) onChatPressed,
    required Function(int id) onProfilePressed,
  }) {
    return {
      'id': id,
      'name': name,
      'email': email,
      'status': status,
      'lastActive': lastActive,
      'role': role,
      'activityCount': activityCount,
      'chat': CellButtonModel(
        text: 'View Chat', // Use the passed button text
        color: Colors.blue,
        onPressed: () {
          onChatPressed(id);
        },
      ),
      'profile': CellButtonModel(
        text: 'View User Profile', // Use the passed button text
        color: Colors.red,
        onPressed: () {
          onProfilePressed(id);
        },
      ),
    };
  }
}
