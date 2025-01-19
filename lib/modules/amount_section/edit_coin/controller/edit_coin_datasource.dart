import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/modules/amount_section/edit_coin/controller/edit_coin_controller.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:http/http.dart' as http;

class EditCoinDataSource extends DataGridSource {
  final EditCoinController controller;
  List<DataGridRow> dataGridRows = [];
  List<Map<String, dynamic>> _paginatedData = [];

  EditCoinDataSource(this.controller, List<Map<String, dynamic>> coins) {
    _paginatedData = coins.getRange(0, controller.selectedPageSize.value).toList();
    buildDataGridRows();
  }

  void buildDataGridRows() {
    dataGridRows = _paginatedData.map<DataGridRow>((coin) {
      return DataGridRow(cells: [
        DataGridCell(columnName: 'fullName', value: coin['fullName']),
        DataGridCell(columnName: 'email', value: coin['email']),
        DataGridCell(columnName: 'amount', value: coin['amount'].join(", ")),
        DataGridCell(columnName: 'level', value: coin['level']),
        DataGridCell(columnName: 'status', value: coin['status']),
        DataGridCell(
          columnName: 'edit',
          value: ElevatedButton(
            onPressed: () => controller.editCoin(coin['userId']),
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
    return DataGridRowAdapter(
      color: Colors.white,
      cells: row.getCells().map<Widget>((cell) {
        if (cell.value is Widget) {
          return Container(alignment: Alignment.center, child: cell.value);
        }
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
          child: Text(cell.value.toString()),
        );
      }).toList(),
    );
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startIndex = newPageIndex * controller.selectedPageSize.value;
    int endIndex = startIndex + controller.selectedPageSize.value;
    if (startIndex < controller.coins.length && endIndex <= controller.coins.length) {
      _paginatedData = controller.coins.getRange(startIndex, endIndex).toList();
    } else {
      _paginatedData = [];
    }
    buildDataGridRows();
    notifyListeners();
    return true;
  }
}