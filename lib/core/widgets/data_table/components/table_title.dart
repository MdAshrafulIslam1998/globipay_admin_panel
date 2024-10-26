import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_title_model.dart';

class TableTitle extends StatelessWidget {
  final TableTitleModel model;
  
  const TableTitle({
    Key? key,
    required this.model,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Text(
      model.title,
      style: TextStyle(
        fontSize: model.fontSize,
        fontWeight: model.fontWeight,
        color: model.textColor,
      ),
    );
  }
}