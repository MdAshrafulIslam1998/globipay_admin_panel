import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/cell_button_model.dart';

class EditCoinModel {
  final int id;
  final String fullName;
  final String email;
  final Map<String, double> amount; // Example: { 'S': 30.00, 'V': 100.00, '&': 300.00 }
  final String status;

  EditCoinModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.amount,
    required this.status,
  });

  Map<String, dynamic> toMap({
    required Function(int id) onEditPressed,
    required Function(int id) onViewPressed,
  }) {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'amount': amount,
      'status': status,
      'editProfile': CellButtonModel(
        text: 'Edit Profile',
        color: Colors.blue,
        onPressed: () {
          onEditPressed(id);
        },
      ),
      'viewProfile': CellButtonModel(
        text: 'View Profile',
        color: Colors.green,
        onPressed: () {
          onViewPressed(id);
        },
      ),
    };
  }
}
