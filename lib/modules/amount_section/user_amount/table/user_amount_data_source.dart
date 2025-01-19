import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/entity/response/trans_history_response.dart/transaction_item_entity.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_item_entity.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UserAmountDataSource extends DataGridSource {
  final List<TransactionItemEntity> users;
  final Function(TransactionItemEntity user, String action)? onActionTap;
  final List<String> visibleColumns;

  UserAmountDataSource(this.users,
      {this.onActionTap, required this.visibleColumns}) {
    buildDataGridRows();
  }

  List<DataGridRow> _dataGridRows = [];

  void buildDataGridRows() {
    _dataGridRows = users
        .map((user) => DataGridRow(
              cells: visibleColumns.map((columnName) {
                switch (columnName) {
                  case 'name':
                    return DataGridCell<String>(
                        columnName: 'name', value: user.name);
                  case 'email':
                    return DataGridCell<String>(
                        columnName: 'email', value: user.createdBy);
                  case 'date':
                    return DataGridCell<String>(
                        columnName: 'date',
                        value: DateFormat('dd-MM-yyyy')
                            .format(DateTime.parse(user.date ?? '')));
                  case 'coin':
                    return DataGridCell<String>(
                        columnName: 'coin', value: user.coin.toString());
                  case 'coin_type':
                    return DataGridCell<String>(
                        columnName: 'coin_type', value: user.coinType);
                  case 'category_name':
                    return DataGridCell<String>(
                        columnName: 'category_name', value: user.categoryName);
                  case 'edit':
                    return DataGridCell<String>(
                        columnName: 'edit',value: user.toString());
                  case 'details':
                    return DataGridCell<String>(
                        columnName: 'details', value: user.toString());
                  default:
                    throw Exception('Invalid column: $columnName');
                }
              }).toList(),
            ))
        .toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      color: Colors.white,
      cells: row.getCells().map<Widget>((cell) {
        if (cell.columnName == 'coin') {
          return Container(
            alignment: Alignment.center,
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF237025).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                cell.value.toString(),
                style: const TextStyle(
                  fontFamily: 'iAWriterQuattroS',
                  color: Color(0xFF237025),
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          );
        }

        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            cell.value.toString(),
            style: const TextStyle(
              fontFamily: 'iAWriterQuattroS',
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }).toList(),
    );
  }
}
