import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/modules/users_section/active_users_new/user_new.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:intl/intl.dart';

class UserDataSource extends DataGridSource {
  final List<User> users;
  final Function(User user, String action)? onActionTap;

  UserDataSource(this.users, {this.onActionTap}) {
    buildDataGridRows();
  }

  List<DataGridRow> _dataGridRows = [];

  void buildDataGridRows() {
    _dataGridRows = users.map((user) => DataGridRow(cells: [
          DataGridCell<String>(columnName: 'name', value: user.name),
          DataGridCell<String>(columnName: 'email', value: user.email),
          DataGridCell<double>(columnName: 'amount', value: user.amount),
          DataGridCell<String>(columnName: 'levelName', value: user.levelName),
          DataGridCell<String>(
              columnName: 'date',
              value: DateFormat('dd-MM-yyyy').format(user.date)),
          DataGridCell<String>(columnName: 'status', value: user.status),
          DataGridCell<User>(columnName: 'details', value: user),
          DataGridCell<User>(columnName: 'delete', value: user),
          DataGridCell<User>(columnName: 'message', value: user),
        ])).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  Widget buildActionButton(Color color, IconData icon, VoidCallback onTap) {
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
        cells: row.getCells().map<Widget>((cell) {
      if (cell.columnName == 'details') {
        return Container(
          alignment: Alignment.center,
          child: buildActionButton(
            Colors.blue,
            Icons.visibility,
            () {
              print('Details button clicked for user: ${(cell.value as User).name}');
              onActionTap?.call(cell.value as User, 'details');
            },
          ),
        );
      } else if (cell.columnName == 'delete') {
        return Container(
          alignment: Alignment.center,
          child: buildActionButton(
            Colors.red,
            Icons.delete,
            () {
              print('Delete button clicked for user: ${(cell.value as User).name}');
              onActionTap?.call(cell.value as User, 'delete');
            },
          ),
        );
      } else if (cell.columnName == 'message') {
        return Container(
          alignment: Alignment.center,
          child: buildActionButton(
            Colors.orange,
            Icons.message,
            () {
              print('Message button clicked for user: ${(cell.value as User).name}');
              onActionTap?.call(cell.value as User, 'message');
            },
          ),
        );
      } else if (cell.columnName == 'amount') {
        return Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text(
            '\$${cell.value.toStringAsFixed(2)}',
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14,
              color: Colors.green,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      } else if (cell.columnName == 'status') {
        return Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: cell.value.toString().toLowerCase() == 'active'
                  ? Colors.green.withOpacity(0.1)
                  : Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              cell.value.toString(),
              style: TextStyle(
                color: cell.value.toString().toLowerCase() == 'active'
                    ? Colors.green
                    : Colors.red,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
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