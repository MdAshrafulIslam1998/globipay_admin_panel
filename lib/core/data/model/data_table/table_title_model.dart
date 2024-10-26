// Models
// lib/core/widgets/table/models/table_title_model.dart
import 'dart:ui';

class TableTitleModel {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  
  const TableTitleModel({
    required this.title,
    this.fontSize = 20,
    this.fontWeight = FontWeight.bold,
    this.textColor = const Color(0xFF2D3748),
  });
}
