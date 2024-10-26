import 'package:flutter/material.dart';

class TableDivider extends StatelessWidget {
  final Color color;
  final double thickness;
  final double indent;
  final double endIndent;
  
  const TableDivider({
    Key? key,
    this.color = const Color(0xFFE2E8F0),
    this.thickness = 1,
    this.indent = 0,
    this.endIndent = 0,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
    );
  }
}