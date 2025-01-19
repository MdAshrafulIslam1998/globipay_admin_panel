import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/entity/response/category/category_item_entity.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';


class CreateCategoryDataSource extends DataGridSource {
  final List<CategoryItemEntity> categories;
  final Function(CategoryItemEntity category)? onDeleteTap;

  CreateCategoryDataSource(this.categories, {this.onDeleteTap}) {
    buildDataGridRows();
  }

  List<DataGridRow> _dataGridRows = [];

  void buildDataGridRows() {
    _dataGridRows = categories.map((category) => DataGridRow(cells: [
          DataGridCell<String>(columnName: 'logo', value: category.image),
          DataGridCell<String>(columnName: 'name', value: category.name),
          DataGridCell<CategoryItemEntity>(columnName: 'delete', value: category),
        ])).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  Widget buildDeleteButton(Color color, IconData icon, VoidCallback onTap) {
    return Material(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            size: 18,
            color: color,
          ),
        ),
      ),
    );
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      color: Colors.white,
        cells: row.getCells().map<Widget>((cell) {
      if (cell.columnName == 'logo') {
        return Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Image.network(
            cell.value.toString(),
            height: 40,
            width: 40,
            fit: BoxFit.contain,
          ),
        );
      } else if (cell.columnName == 'delete') {
        return Container(
          alignment: Alignment.center,
          child: buildDeleteButton(
            Colors.red,
            Icons.delete,
            () {
              onDeleteTap?.call(cell.value as CategoryItemEntity);
            },
          ),
        );
      } 
      return Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: Text(
          cell.value.toString(),
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 14,
            color: Color(0xFF444444),
          ),
        ),
      );
    }).toList());
  }
}