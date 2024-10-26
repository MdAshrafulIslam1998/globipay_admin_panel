import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_action_model.dart';

class TableActionButtons extends StatelessWidget {
  final dynamic rowData;
  final List<TableActionModel> actions;
  final Function(String, dynamic) onActionPressed;
  
  const TableActionButtons({
    Key? key,
    required this.rowData,
    required this.actions,
    required this.onActionPressed,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: actions.map((action) {
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: action.backgroundColor,
              foregroundColor: action.textColor,
            ),
            onPressed: () => onActionPressed(action.key, rowData),
            child: Text(action.label),
          ),
        );
      }).toList(),
    );
  }
}