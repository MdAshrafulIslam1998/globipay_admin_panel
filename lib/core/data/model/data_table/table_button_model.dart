import 'package:flutter/material.dart';

class TableButtonModel {
  final String text;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final EdgeInsets padding;
  final Function() onPressed;
  
  const TableButtonModel({
    required this.text,
    required this.icon,
    required this.onPressed,
    this.backgroundColor = const Color(0xFF3B82F6),
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  });
}