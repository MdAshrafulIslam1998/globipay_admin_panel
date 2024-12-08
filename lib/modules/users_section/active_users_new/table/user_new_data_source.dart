import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/modules/users_section/active_users_new/user_new.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:intl/intl.dart';

class UserDataSource extends DataGridSource {
  final List<User> users;
  final Function(User user, String action)? onActionTap;
  final List<String> visibleColumns; // Add visibleColumns

  UserDataSource(this.users, {this.onActionTap, required this.visibleColumns}) {
    buildDataGridRows();
  }

  List<DataGridRow> _dataGridRows = [];

  void buildDataGridRows() {
    // Build rows based on the visible columns
    _dataGridRows = users
        .map((user) => DataGridRow(
              cells: visibleColumns.map((columnName) {
                switch (columnName) {
                  case 'name':
                    return DataGridCell<String>(columnName: 'name', value: user.name);
                  case 'email':
                    return DataGridCell<String>(columnName: 'email', value: user.email);
                  case 'primary':
                    return DataGridCell<double>(columnName: 'primary', value: user.primary);
                  case 'secondary':
                    return DataGridCell<double>(columnName: 'secondary', value: user.secondary);
                  case 'levelName':
                    return DataGridCell<String>(columnName: 'levelName', value: user.levelName);
                  case 'date':
                    return DataGridCell<String>(
                        columnName: 'date',
                        value: DateFormat('dd-MM-yyyy').format(user.date));
                  case 'status':
                    return DataGridCell<String>(columnName: 'status', value: user.status);
                  case 'details':
                    return DataGridCell<User>(columnName: 'details', value: user);
                  case 'delete':
                    return DataGridCell<User>(columnName: 'delete', value: user);
                  case 'message':
                    return DataGridCell<User>(columnName: 'message', value: user);
                  default:
                    throw Exception('Invalid column: $columnName');
                }
              }).toList(),
            ))
        .toList();
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
      } else if (cell.columnName == 'primary') {
        return Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text(
            '\$ ${cell.value.toStringAsFixed(2)}',
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14,
              color: Colors.green,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      } else if (cell.columnName == 'secondary') {
        return Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text(
            '\$ ${cell.value.toStringAsFixed(2)}',
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14,
              color: Colors.blue,
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
              color: Colors.green.withOpacity(0.1), // Light green background
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              cell.value.toString(),
              style: TextStyle(
                color: Colors.green, // Always green text
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
