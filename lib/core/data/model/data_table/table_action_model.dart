import 'dart:ui';

class TableActionModel {
  final String label;
  final String key;
  final Color? backgroundColor;
  final Color? textColor;
  
  TableActionModel({
    required this.label,
    required this.key,
    this.backgroundColor,
    this.textColor,
  });
}
