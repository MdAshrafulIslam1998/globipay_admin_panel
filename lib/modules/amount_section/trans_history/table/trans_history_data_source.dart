import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/entity/response/trans_history_response.dart/transaction_item_entity.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_item_entity.dart';
import 'package:globipay_admin_panel/modules/amount_section/user_amount/table/helper/category_visualize_helper.dart';
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
      color: Colors.white,
      cells: row.getCells().map<Widget>((cell) {
        if (cell.columnName == 'coin') {
          return CoinText(
            rawData: cell.value.toString(),
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

class CoinText extends StatelessWidget {
  final String rawData;
  const CoinText({super.key, required this.rawData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              rawData,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
