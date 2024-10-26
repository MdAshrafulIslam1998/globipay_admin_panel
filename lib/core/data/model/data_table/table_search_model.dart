import 'dart:ui';

import 'package:flutter/material.dart';

class TableSearchModel {
  final String placeholder;
  final double borderRadius;
  final Color borderColor;
  final Color backgroundColor;
  final TextStyle textStyle;
  
  const TableSearchModel({
    this.placeholder = 'Search...',
    this.borderRadius = 8.0,
    this.borderColor = const Color(0xFFE2E8F0),
    this.backgroundColor = Colors.white,
    this.textStyle = const TextStyle(
      fontSize: 14,
      color: Color(0xFF4A5568),
    ),
  });
}