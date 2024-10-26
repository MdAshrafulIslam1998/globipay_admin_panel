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

  Map<String, dynamic> toMap(Function(int id) onPressed,
      {required String buttonText, required String messegeButtonText,required Function(int id) onMessagePressed}) {
    return {
      'id': id,
      'name': name,
      'email': email,
      'status': status,
      'lastActive': lastActive,
      'role': role,
      'activityCount': activityCount,
      'actions': CellButtonModel(
        text: buttonText, // Use the passed button text
        color: Colors.blue,
        onPressed: () {
          onPressed(id);
        },
      ),
      'messege': CellButtonModel(
        text: messegeButtonText, // Use the passed button text
        color: Colors.red,
        onPressed: () {
          onMessagePressed(id);
        },
      ),
    };
  }
}
