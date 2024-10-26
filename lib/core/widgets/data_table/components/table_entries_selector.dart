import 'package:flutter/material.dart';

class TableEntriesSelector extends StatelessWidget {
  final List<int> options;
  final int value;
  final Function(int) onChanged;
  final TextStyle labelStyle;
  final TextStyle dropdownStyle;
  
  const TableEntriesSelector({
    Key? key,
    required this.options,
    required this.value,
    required this.onChanged,
    this.labelStyle = const TextStyle(
      fontSize: 14,
      color: Color(0xFF4A5568),
    ),
    this.dropdownStyle = const TextStyle(
      fontSize: 14,
      color: Color(0xFF2D3748),
      fontWeight: FontWeight.w500,
    ),
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Show', style: labelStyle),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE2E8F0)),
            borderRadius: BorderRadius.circular(6),
          ),
          child: DropdownButton<int>(
            value: value,
            items: options.map((option) {
              return DropdownMenuItem<int>(
                value: option,
                child: Text(
                  option.toString(),
                  style: dropdownStyle,
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              if (newValue != null) onChanged(newValue);
            },
            underline: const SizedBox(),
            icon: const Icon(Icons.keyboard_arrow_down),
          ),
        ),
        const SizedBox(width: 8),
        Text('entries', style: labelStyle),
      ],
    );
  }
}
