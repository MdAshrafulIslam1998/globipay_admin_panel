import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/widgets/app_print.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_item_entity.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:intl/intl.dart';

class UserDataSource extends DataGridSource {
  final List<UserResponseItemEntity> users;
  final Function(UserResponseItemEntity user, String action)? onActionTap;
  final List<String> visibleColumns;

  UserDataSource(this.users, {this.onActionTap, required this.visibleColumns}) {
    buildDataGridRows();
  }

  List<DataGridRow> _dataGridRows = [];

  void buildDataGridRows() {
    _dataGridRows = users
        .map((user) => DataGridRow(
              cells: visibleColumns.map((columnName) {
                switch (columnName) {
                  case 'code':
                    return DataGridCell<String>(
                        columnName: 'code', value: user.user_code ?? 'NAN');
                  case 'name':
                    return DataGridCell<String>(
                        columnName: 'name', value: user.name ?? '');
                  case 'email':
                    return DataGridCell<String>(
                        columnName: 'email', value: user.email ?? '');
                  case 'phone':
                    return DataGridCell<String>(
                        columnName: 'phone', value: user.phone ?? '');
                  case 'primary':
                    return DataGridCell<double>(
                        columnName: 'primary', value: user.primary ?? 0.0);
                  case 'secondary':
                    return DataGridCell<double>(
                        columnName: 'secondary', value: user.secondary ?? 0.0);
                  case 'levelName':
                    return DataGridCell<String>(
                        columnName: 'levelName', value: user.levelName ?? '');
                  case 'date':
                    return DataGridCell<String>(
                        columnName: 'date',
                        value: "${DateFormat('dd MMM yyyy', 'en_US').format(DateTime.parse(user.date ?? ''))} \n"
                            "${DateFormat('hh:mm a', 'en_US').format(DateTime.parse(user.date ?? ''))}");
                    case 'status':
                    return DataGridCell<String>(
                        columnName: 'status', value: user.status ?? '');
                  case 'details':
                    return DataGridCell<UserResponseItemEntity>(
                        columnName: 'details', value: user);
                  case 'delete':
                    return DataGridCell<UserResponseItemEntity>(
                        columnName: 'delete', value: user);
                  case 'message':
                    return DataGridCell<UserResponseItemEntity>(
                        columnName: 'message', value: user);
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
        if (cell.columnName == 'details') {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 14.0), // Add padding right
            child: buildActionButton(Colors.blue, Icons.visibility, () {
              print(
                  'Details button clicked for user: ${(cell.value as UserResponseItemEntity).email}');
              final user = cell.value as UserResponseItemEntity;
              appPrint('User: ${user.toJson()}');
              onActionTap?.call(user, 'details');
            }),
          );
        } else if (cell.columnName == 'delete') {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 14.0), // Add padding right
            child: buildActionButton(Colors.red, Icons.delete, () {
              print(
                  'Delete button clicked for user: ${(cell.value as UserResponseItemEntity).name}');
              onActionTap?.call(cell.value as UserResponseItemEntity, 'delete');
            }),
          );
        } else if (cell.columnName == 'levelName') {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 14.0), // Add padding right
            child: Text(
              cell.value.toString(),
              overflow: TextOverflow
                  .ellipsis, // Ensure text is truncated with ellipsis
              style: TextStyle(
                fontFamily: 'iAWriterQuattroS',
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        } else if (cell.columnName == 'phone') {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 14.0), // Add padding right
            child: Text(
              cell.value.toString(),
              overflow: TextOverflow
                  .ellipsis, // Ensure text is truncated with ellipsis
              style: TextStyle(
                fontFamily: 'iAWriterQuattroS',
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        } else if (cell.columnName == 'date') {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 14.0), // Add padding right
            child: Text(
              cell.value.toString(),
              overflow: TextOverflow
                  .ellipsis, // Ensure text is truncated with ellipsis
              style: TextStyle(
                fontFamily: 'iAWriterQuattroS',
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        } else if (cell.columnName == 'message') {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 14.0), // Add padding right
            child: buildActionButton(Colors.orange, Icons.message, () {
              print(
                  'Message button clicked for user: ${(cell.value as UserResponseItemEntity).name}');
              onActionTap?.call(
                  cell.value as UserResponseItemEntity, 'message');
            }),
          );
        } else if (cell.columnName == 'primary' ||
            cell.columnName == 'secondary') {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 14.0), // Add padding right
            child: Text(
              '\$ ${cell.value.toStringAsFixed(2)}',
              overflow: TextOverflow
                  .ellipsis, // Ensure text is truncated with ellipsis
              style: TextStyle(
                fontFamily: 'iAWriterQuattroS',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color:
                    cell.columnName == 'primary' ? Colors.green : Colors.blue,
              ),
            ),
          );
        } else if (cell.columnName == 'status') {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 14.0), // Add padding right
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                cell.value.toString(),
                overflow: TextOverflow
                    .ellipsis, // Ensure text is truncated with ellipsis
                style: const TextStyle(
                  fontFamily: 'iAWriterQuattroS',
                  color: Colors.green,
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
