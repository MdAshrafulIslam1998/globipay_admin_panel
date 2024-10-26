import 'package:flutter/material.dart';

class CellButtonModel {
  final String text;
  final Color color; // Added color parameter
  final VoidCallback onPressed;

  CellButtonModel({
    required this.text,
    required this.color, // Initialize color parameter
    required this.onPressed,
  });
}
