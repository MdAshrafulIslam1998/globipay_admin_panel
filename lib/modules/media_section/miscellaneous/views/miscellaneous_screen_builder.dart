import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_view_state.dart';
import 'package:globipay_admin_panel/core/theme/app_colors.dart';
import 'package:globipay_admin_panel/modules/media_section/miscellaneous/controller/miscellaneous_controller.dart';
import 'package:globipay_admin_panel/modules/media_section/miscellaneous/table/miscellaneous_data_pager_delegate.dart';
import 'package:globipay_admin_panel/modules/media_section/miscellaneous/table/miscellaneous_data_source.dart';
import 'package:globipay_admin_panel/modules/media_section/miscellaneous/table/table_header_const.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class MiscellaneousScreenBuilder extends StatefulWidget {
  const MiscellaneousScreenBuilder({super.key});
  @override
  State<MiscellaneousScreenBuilder> createState() =>
      _MiscellaneousScreenBuilderState();
}

class _MiscellaneousScreenBuilderState
    extends BaseViewState<MiscellaneousScreenBuilder, MiscellaneousController> {
  late Map<String, double> columnWidths = {
    MiscTableHeaderConst.ID: double.nan,
    MiscTableHeaderConst.FEATURE_CODE: double.nan,
    MiscTableHeaderConst.TYPE: double.nan,
    MiscTableHeaderConst.CONTENT: double.nan,
    MiscTableHeaderConst.DETAILS: double.nan,
    MiscTableHeaderConst.DELETE: double.nan,
  };

  @override
  void initState() {
    controller.onInit();
    super.initState();
  }

  
  @override
  Widget body(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: const BoxDecoration(
              color: AppColors.projectBlue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Miscellaneous',
                  style: TextStyle(
                    fontFamily: 'newyork',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.projectButtonBlue2,
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () => controller.addNewMisc(),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        '+ Add New Item',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.projectButtonBlue2,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Show entries:   ',
                      style: TextStyle(
                        fontFamily: 'newyork',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.projectButtonBlue2,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                      child: Obx(() => DropdownButton<int>(
                            value: controller.pageSize.value,
                            underline: Container(),
                            items: [5, 10, 20, 30].map((size) {
                              return DropdownMenuItem<int>(
                                value: size,
                                child: Text(
                                  size.toString(),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(143, 0, 0, 0),
                                    fontFamily: 'newyork',
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (newSize) {
                              if (newSize != null) {
                                controller.updatePageSize(newSize);
                              }
                            },
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // DataGrid
          Expanded(
            child: Obx(
              () => SfDataGridTheme(
                data: SfDataGridThemeData(
                  headerColor: const Color(0xFFF4F7FF),
                ),
                child: SfDataGrid(
                  source: MiscellaneousDataSource(
                    controller.miscs.value,
                    onActionTap: (user, action) {
                      switch (action) {
                        case MiscTableHeaderConst.DETAILS:
                          controller.onDetailsTap(user);
                          break;
                        case MiscTableHeaderConst.DELETE:
                          controller.removeMisc(user.service_id);
                          break;
                      }
                    },
                    visibleColumns: controller.visibleColumns.value,
                  ),
                  allowColumnsResizing: true,
                  onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
                    setState(() {
                      columnWidths[details.column.columnName] = details.width;
                    });
                    return true;
                  },
                  gridLinesVisibility: GridLinesVisibility.both,
                  headerGridLinesVisibility: GridLinesVisibility.both,
                  columnWidthMode: ColumnWidthMode.fill,
                  columns: _buildColumns(controller.visibleColumns.value),
                  rowHeight: 50,
                  headerRowHeight: 60,
                ),
              ),
            ),
          ),
          // Pagination
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: const BoxDecoration(
              color: Color(0xFFF4F7FF),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Text(
                    'Total Items: ${controller.totalItems}',
                    style: const TextStyle(
                      fontFamily: 'newyork',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => SfDataPagerTheme(
                      data: SfDataPagerThemeData(
                        itemColor: Colors.white,
                        selectedItemColor: const Color(0xFF2C3E50),
                        itemBorderRadius: BorderRadius.circular(50),
                        backgroundColor: const Color(0xFFF4F7FF),
                      ),
                      child: SfDataPager(
                        delegate: MiscellaneousDataPagerDelegate(controller),
                        pageCount: max(
                          1,
                          (controller.totalItems.value /
                                  controller.pageSize.value)
                              .ceilToDouble(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<GridColumn> _buildColumns(List<String> visibleColumns) {
    final columnDefinitions = {
      MiscTableHeaderConst.ID: {'title': 'ID', 'paddingPercent': 20},
      MiscTableHeaderConst.FEATURE_CODE: {
        'title': 'Feature Code',
        'paddingPercent': 25
      },
      MiscTableHeaderConst.TYPE: {'title': 'Type', 'paddingPercent': 25},
      MiscTableHeaderConst.CONTENT: {'title': 'Content', 'paddingPercent': 10},
      MiscTableHeaderConst.DETAILS: {'title': 'Details', 'paddingPercent': 10},
      MiscTableHeaderConst.DELETE: {'title': 'Delete', 'paddingPercent': 10},
    };
    return visibleColumns.map((colName) {
      final columnData = columnDefinitions[colName];
      final title = (columnData?['title'] as String?) ?? colName;
      final paddingPercent = (columnData?['paddingPercent'] as int?) ?? 10;
      return GridColumn(
        columnName: colName,
        width: columnWidths[colName]!,
        label: _buildHeaderCell(title, paddingPercent),
      );
    }).toList();
  }

  Widget _buildHeaderCell(String text, int paddingPercent) {
    final double horizontalPadding = paddingPercent.toDouble();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'newyork',
          fontSize: 15,
          fontWeight: FontWeight.w900,
          color: Color(0xFF2C3E50),
        ),
      ),
    );
  }
}
