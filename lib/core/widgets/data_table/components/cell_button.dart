// cell_button.dart
import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/cell_button_model.dart';

class CellButton extends StatelessWidget {
  final CellButtonModel model;

  const CellButton({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: model.onPressed,
      child: Text(model.text),
    );
  }
}