/*
import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/modules/active_users/controller/active_users_controller.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ActiveUsersDatasource extends DataGridSource {
  final ActiveUsersController controller;  // Add controller as a parameter
  List<DataGridRow> dataGridRows = [];

  ActiveUsersDatasource(this.controller, List<Map<String, dynamic>> coins) {
    dataGridRows = coins.map<DataGridRow>((coin) {
      return DataGridRow(cells: [
        DataGridCell(columnName: 'fullName', value: coin['fullName']),
        DataGridCell(columnName: 'email', value: coin['email']),
        DataGridCell(columnName: 'amount', value: coin['amount'].join(", ")),
        DataGridCell(columnName: 'level', value: coin['level']),
        DataGridCell(columnName: 'status', value: coin['status']),
        DataGridCell(
          columnName: 'edit',
          value: ElevatedButton(
            onPressed: () => controller.editCoin(coin['userId']),  // Now works because controller is passed
            child: Text("Edit"),
          ),
        ),
        DataGridCell(
          columnName: 'details',
          value: ElevatedButton(
            onPressed: () => controller.viewDetails(coin['userId']),
            child: Text("Profile"),
          ),
        ),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: row.getCells().map<Widget>((cell) {
      if (cell.value is Widget) {
        return Container(alignment: Alignment.center, child: cell.value);
      }
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(cell.value.toString()),
      );
    }).toList());
  }
}
*/
