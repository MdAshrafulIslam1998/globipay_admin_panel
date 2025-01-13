import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/entity/response/trans_history_response.dart/transaction_item_entity.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_item_entity.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TransHistoryDataSource extends DataGridSource {
  final List<TransactionItemEntity> users;
  final Function(TransactionItemEntity user, String action)? onActionTap;
  final List<String> visibleColumns;

  TransHistoryDataSource(this.users,
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
                        columnName: 'email', value: user.email);
                  case 'date':
                    return DataGridCell<String>(
                        columnName: 'date',
                        value: DateFormat('dd-MM-yyyy HH:mm')
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
          child: Icon(icon, size: 18, color: color),
        ),
      ),
    );
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((cell) {
        if (cell.columnName == 'date') {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 14.0), // Add padding right
            child: Text(
              cell.value.toString(),
              overflow: TextOverflow
                  .ellipsis, // Ensure text is truncated with ellipsis
              style: const TextStyle(
                fontFamily: 'iAWriterQuattroS',
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        } else if (cell.columnName == 'name') {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 14.0), // Add padding right
            child: Text(
              cell.value.toString(),
              overflow: TextOverflow
                  .ellipsis, // Ensure text is truncated with ellipsis
              style: const TextStyle(
                fontFamily: 'iAWriterQuattroS',
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        } else if (cell.columnName == 'email') {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 14.0), // Add padding right
            child: Text(
              cell.value.toString(),
              overflow: TextOverflow
                  .ellipsis, // Ensure text is truncated with ellipsis
              style: const TextStyle(
                fontFamily: 'iAWriterQuattroS',
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        } else if (cell.columnName == 'coin_type') {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 14.0), // Add padding right
            child: Text(
              cell.value.toString(),
              overflow: TextOverflow
                  .ellipsis, // Ensure text is truncated with ellipsis
              style: const TextStyle(
                fontFamily: 'iAWriterQuattroS',
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }
        else if (cell.columnName == 'category_name') {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 14.0), // Add padding right
            child: Text(
              cell.value.toString(),
              overflow: TextOverflow
                  .ellipsis, // Ensure text is truncated with ellipsis
              style: const TextStyle(
                fontFamily: 'iAWriterQuattroS',
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        } else if (cell.columnName == 'coin') {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 14.0), // Add padding right
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF237025).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                cell.value.toString(),
                overflow: TextOverflow
                    .ellipsis, // Ensure text is truncated with ellipsis
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
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 14.0), // Add padding right
          child: Text(
            cell.value.toString(),
            overflow:
                TextOverflow.ellipsis, // Ensure text is truncated with ellipsis
            style: const TextStyle(
              fontFamily: 'iAWriterQuattroS',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF444444),
            ),
          ),
        );
      }).toList(),
    );
  }
}
