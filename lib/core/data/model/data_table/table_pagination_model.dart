import 'dart:ui';

import 'package:flutter/material.dart';

class TablePaginationModel {
  final Color activeColor;
  final Color inactiveColor;
  final Color textColor;
  final double borderRadius;
  final EdgeInsets padding;
  final int visiblePages;
  
  const TablePaginationModel({
    this.activeColor = const Color(0xFF3B82F6),
    this.inactiveColor = Colors.white,
    this.textColor = const Color(0xFF2D3748),
    this.borderRadius = 4.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.visiblePages = 5,
  });
}
