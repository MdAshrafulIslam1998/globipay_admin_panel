import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/modules/users_section/active_users/user.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UserDataSource extends DataGridSource {
  final List<User> users;
  final Function(User user, String action)? onActionTap;

  UserDataSource(this.users, {this.onActionTap}){
    buildDataGridRows();
  }

  List<DataGridRow> _dataGridRows = [];

  void buildDataGridRows() {
    _dataGridRows = users
        .map((user) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'id', value: user.id),
      DataGridCell<String>(columnName: 'name', value: user.name),
      DataGridCell<String>(
          columnName: 'designation', value: user.designation),
      DataGridCell<int>(columnName: 'age', value: user.age),
      DataGridCell<User>(columnName: 'actions', value: user),
    ]))
        .toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((cell) {
          if (cell.columnName == 'actions') {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // View Button
                  Material(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        // Handle view action
                        onActionTap?.call(cell.value as User, 'view');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.visibility,
                          size: 18,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Edit Button
                  Material(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        // Handle edit action
                        onActionTap?.call(cell.value as User, 'edit');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.edit,
                          size: 18,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Message Button
                  Material(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        // Handle message action
                        onActionTap?.call(cell.value as User, 'message');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.message,
                          size: 18,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text(cell.value.toString()),
          );
        }).toList());
  }
}