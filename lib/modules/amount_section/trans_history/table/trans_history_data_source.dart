// 6. transaction_data_source.dart
import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/modules/amount_section/trans_history/trans_history.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:intl/intl.dart';

class TransactionDataSource extends DataGridSource {
  final List<Transaction> transactions;

  TransactionDataSource(this.transactions) {
    buildDataGridRows();
  }

  List<DataGridRow> _dataGridRows = [];

  void buildDataGridRows() {
    _dataGridRows = transactions.map((transaction) => DataGridRow(cells: [
          DataGridCell<String>(columnName: 'name', value: transaction.name),
          DataGridCell<String>(columnName: 'email', value: transaction.email),
          DataGridCell<String>(
              columnName: 'date',
              value: DateFormat('dd-MM-yyyy').format(transaction.date)),
          DataGridCell<int>(columnName: 'coin', value: transaction.coin),
          DataGridCell<String>(
              columnName: 'categoryName', value: transaction.categoryName),
          DataGridCell<String>(columnName: 'coinType', value: transaction.coinType),
        ])).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((cell) {
      if (cell.columnName == 'coin') {
        return Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text(
            '${cell.value}',
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14,
              color: Colors.green,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      } else if (cell.columnName == 'coinType') {
        return Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: cell.value.toString().toLowerCase() == 'primary'
                  ? Colors.blue.withOpacity(0.1)
                  : Colors.purple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              cell.value.toString(),
              style: TextStyle(
                color: cell.value.toString().toLowerCase() == 'primary'
                    ? Colors.blue
                    : Colors.purple,
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
