import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/modules/user_levels/user_levels.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UserLevelDataSource extends DataGridSource {
  final List<UserLevel> users;
  final Function(UserLevel user, String action)? onActionTap;

  UserLevelDataSource(this.users, {this.onActionTap}) {
    buildDataGridRows();
  }

  List<DataGridRow> _dataGridRows = [];

  void buildDataGridRows() {
    _dataGridRows = users.map((user) => DataGridRow(cells: [
          DataGridCell<String>(columnName: 'name', value: user.name),
          DataGridCell<String>(columnName: 'email', value: user.email),
          DataGridCell<double>(columnName: 'amount', value: user.amount),
          DataGridCell<String>(columnName: 'level', value: user.levelName),
          DataGridCell<String>(
            columnName: 'date',
            value: DateFormat('dd-MM-yyyy').format(user.date),
          ),
          DataGridCell<String>(columnName: 'status', value: user.status),
          DataGridCell<String>(columnName: 'edit', value: 'edit'),
          DataGridCell<String>(columnName: 'details', value: 'details'),
          DataGridCell<String>(columnName: 'delete', value: 'delete'),
        ])).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        final user = users[rows.indexOf(row)];
        
        if (dataGridCell.columnName == 'edit') {
          return IconButton(
            icon: const Icon(Icons.edit, color: Colors.green),
            onPressed: () {
              onActionTap?.call(user, 'edit');
              print("Edit button clicked for ${user.name}");
            },
          );
        } else if (dataGridCell.columnName == 'details') {
          return IconButton(
            icon: const Icon(Icons.info, color: Colors.blue),
            onPressed: () {
              onActionTap?.call(user, 'details');
              print("Details button clicked for ${user.name}");
            },
          );
        } else if (dataGridCell.columnName == 'delete') {
          return IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              onActionTap?.call(user, 'delete');
              print("Delete button clicked for ${user.name}");
            },
          );
        } else {
          return Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              dataGridCell.value.toString(),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }
      }).toList(),
    );
  }
}
