import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_search_model.dart';

class TableSearch extends StatelessWidget {
  final TableSearchModel model;
  final Function(String) onSearch;
  
  const TableSearch({
    Key? key,
    required this.model,
    required this.onSearch,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: model.backgroundColor,
        borderRadius: BorderRadius.circular(model.borderRadius),
        border: Border.all(color: model.borderColor),
      ),
      child: TextField(
        style: model.textStyle,
        onChanged: onSearch,
        decoration: InputDecoration(
          hintText: model.placeholder,
          prefixIcon: const Icon(Icons.search, color: Color(0xFF718096)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
