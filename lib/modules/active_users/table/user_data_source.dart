import 'package:flutter/cupertino.dart';
import 'package:globipay_admin_panel/modules/active_users/user.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

/**
 * Created by Abdullah on 10/11/24.
 */

class UserDataSource extends DataGridSource {
  final List<User> users;

  UserDataSource(this.users) {
    buildDataGridRows();
  }

  List<DataGridRow> _dataGridRows = [];

  void buildDataGridRows() {
    _dataGridRows = users
        .map((user) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'id', value: user.id),
      DataGridCell<String>(columnName: 'name', value: user.name),
      DataGridCell<String>(columnName: 'designation', value: user.designation),
      DataGridCell<int>(columnName: 'age', value: user.age),
    ]))
        .toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      for (var cell in row.getCells())
        Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text(cell.value.toString()),
        ),
    ]);
  }
}