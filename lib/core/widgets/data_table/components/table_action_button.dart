import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_button_model.dart';

class TableActionButton extends StatelessWidget {
  final TableButtonModel model;
  
  const TableActionButton({
    Key? key,
    required this.model,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: model.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: model.backgroundColor,
        foregroundColor: model.textColor,
        padding: model.padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(model.borderRadius),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(model.icon, size: 18),
          const SizedBox(width: 8),
          Text(model.text),
        ],
      ),
    );
  }
}
