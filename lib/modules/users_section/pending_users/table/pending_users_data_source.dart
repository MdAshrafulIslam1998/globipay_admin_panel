import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/modules/users_section/pending_users/pending_user.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PendingUserDataSource extends DataGridSource {
  final List<PendingUser> users;
  final Function(PendingUser user, String action)? onActionTap;

  PendingUserDataSource(this.users, {this.onActionTap}) {
    buildDataGridRows();
  }

  List<DataGridRow> _dataGridRows = [];

  void buildDataGridRows() {
    // Make sure these cells match exactly with the GridColumns defined in the screen builder
    _dataGridRows = users
        .map((user) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'fullName', value: user.name),
              DataGridCell<String>(columnName: 'email', value: user.email),
              DataGridCell<String>(
                  columnName: 'date',
                  value: DateFormat('dd-MM-yyyy').format(user.date)),
              DataGridCell<String>(columnName: 'status', value: user.status),
              DataGridCell<PendingUser>(columnName: 'document', value: user),
            ]))
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
        if (cell.columnName == 'status') {
          return Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                cell.value.toString(),
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        } else if (cell.columnName == 'document') {
          return Container(
            alignment: Alignment.center,
            child: buildActionButton(
              Colors.blue,
              Icons.visibility,
              () {
                print(
                    'Document button clicked for user: ${(cell.value as PendingUser).name}');
                onActionTap?.call(cell.value as PendingUser, 'Document');
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
      }).toList(),
    );
  }
}
