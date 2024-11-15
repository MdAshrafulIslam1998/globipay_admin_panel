import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/modules/amount_section/user_amount/user_amount.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UserAmountDataSource extends DataGridSource {
  final List<UserAmount> users;
  final Function(UserAmount user, String action)? onActionTap;

  UserAmountDataSource(this.users, {this.onActionTap}) {
    buildDataGridRows();
  }

  List<DataGridRow> _dataGridRows = [];

  void buildDataGridRows() {
    _dataGridRows = users.map((user) => DataGridRow(cells: [
          DataGridCell<String>(columnName: 'name', value: user.name),
          DataGridCell<String>(columnName: 'email', value: user.email),
          DataGridCell<Map<String, Map<String, int>>>(
              columnName: 'amount', value: user.amount),
          DataGridCell<String>(columnName: 'status', value: user.status),
          DataGridCell<String>(columnName: 'level', value: user.levelName),
          DataGridCell<String>(columnName: 'edit', value: 'edit'),
          DataGridCell<String>(columnName: 'details', value: 'details'),
        ])).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        if (dataGridCell.columnName == 'amount') {
          Map<String, Map<String, int>> amount = dataGridCell.value;
          return Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: amount.entries.map((entry) {
                  final category = entry.key;
                  final primary = entry.value['PRIMARY'] ?? 0;
                  final secondary = entry.value['SECONDARY'] ?? 0;
                  return Text(
                    '$category - Primary: $primary, Secondary: $secondary',
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                  );
                }).toList(),
              ),
            ),
          );
        } else if (dataGridCell.columnName == 'edit' ||
                   dataGridCell.columnName == 'details') {
          final icon = dataGridCell.columnName == 'edit' ? Icons.edit : Icons.info;
          return IconButton(
            icon: Icon(icon, color: Colors.blue),
            onPressed: () {
              final user = users[rows.indexOf(row)];
              final action = dataGridCell.columnName;
              onActionTap?.call(user, action);
            },
          );
        }
        return Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(dataGridCell.value.toString()),
        );
      }).toList(),
    );
  }
}
