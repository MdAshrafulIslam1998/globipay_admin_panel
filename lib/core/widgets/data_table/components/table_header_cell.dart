import 'package:flutter/material.dart';

class TableHeaderCell extends StatelessWidget {
  final String text;
  final bool sortable;
  final bool isActive;
  final bool isAscending;
  final Function()? onSort;
  final TextStyle textStyle;
  
  const TableHeaderCell({
    Key? key,
    required this.text,
    this.sortable = true,
    this.isActive = false,
    this.isAscending = true,
    this.onSort,
    this.textStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Color(0xFF2D3748),
    ),
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: sortable ? onSort : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Text(text, style: textStyle),
            if (sortable) ...[
              const SizedBox(width: 4),
              Icon(
                isActive
                    ? (isAscending ? Icons.arrow_upward : Icons.arrow_downward)
                    : Icons.unfold_more,
                size: 16,
                color: isActive ? const Color(0xFF3B82F6) : const Color(0xFF718096),
              ),
            ],
          ],
        ),
      ),
    );
  }
}