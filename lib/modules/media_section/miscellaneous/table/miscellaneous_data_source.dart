import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/widgets/app_print.dart';
import 'package:globipay_admin_panel/entity/response/misc/misc_response_item_entity.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_item_entity.dart';
import 'package:globipay_admin_panel/modules/media_section/miscellaneous/table/table_header_const.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:intl/intl.dart';
/**
 * Created by Abdullah on 14/12/24.
 */


class MiscellaneousDataSource extends DataGridSource {
  final List<MiscResponseItemEntity> miscs;
  final Function(MiscResponseItemEntity user, String action)? onActionTap;
  final List<String> visibleColumns;

  MiscellaneousDataSource(this.miscs, {this.onActionTap, required this.visibleColumns}) {
    buildDataGridRows();
  }

  List<DataGridRow> _dataGridRows = [];

  void buildDataGridRows() {
    _dataGridRows = miscs
        .map((user) => DataGridRow(
      cells: visibleColumns.map((columnName) {
        switch (columnName) {
          case MiscTableHeaderConst.ID:
            return DataGridCell<String>(
                columnName: MiscTableHeaderConst.ID, value: user.service_id.toString());
          case MiscTableHeaderConst.FEATURE_CODE:
            return DataGridCell<String>(
                columnName: MiscTableHeaderConst.FEATURE_CODE, value: user.feature_code);
          case MiscTableHeaderConst.TYPE:
            return DataGridCell<String>(
                columnName: MiscTableHeaderConst.TYPE, value: user.type);
          case MiscTableHeaderConst.CONTENT:
            return DataGridCell<String>(
                columnName: MiscTableHeaderConst.CONTENT, value: user.content);

          case MiscTableHeaderConst.DETAILS:
            return DataGridCell<String>(
                columnName: MiscTableHeaderConst.DETAILS, value: "Details");

          case MiscTableHeaderConst.DELETE:
            return DataGridCell<String>(
                columnName: MiscTableHeaderConst.DELETE, value: "Delete");


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
        if (cell.columnName == MiscTableHeaderConst.DETAILS) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 14.0), // Add padding right
            child: buildActionButton(Colors.blue, Icons.visibility, () {
             onActionTap?.call(
                  cell.value as MiscResponseItemEntity, MiscTableHeaderConst.DETAILS);
            }),
          );
        } else if (cell.columnName == MiscTableHeaderConst.DELETE) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 14.0), // Add padding right
            child: buildActionButton(Colors.red, Icons.delete, () {
              onActionTap?.call(cell.value as MiscResponseItemEntity, MiscTableHeaderConst.DELETE);
            }),
          );
        } else if (cell.columnName == MiscTableHeaderConst.ID) {
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
        } else if (cell.columnName == MiscTableHeaderConst.FEATURE_CODE) {
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
        } else if (cell.columnName == MiscTableHeaderConst.TYPE) {
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
        } else if (cell.columnName == MiscTableHeaderConst.CONTENT) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 14.0), // Add padding right
            child: Text(
              cell.value.toString(),
              maxLines: 1,
              overflow: TextOverflow
                  .ellipsis, // Ensure text is truncated with ellipsis
              style: TextStyle(
                fontFamily: 'iAWriterQuattroS',
                fontSize: 14,
                fontWeight: FontWeight.w600,
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
