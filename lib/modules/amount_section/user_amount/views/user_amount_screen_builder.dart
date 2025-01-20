import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:globipay_admin_panel/core/base/base_view_state.dart';
import 'package:globipay_admin_panel/core/constants/app_spaces.dart';
import 'package:globipay_admin_panel/core/constants/enum/sort_type.dart';
import 'package:globipay_admin_panel/core/theme/app_colors.dart';
import 'package:globipay_admin_panel/entity/response/category/category_item_entity.dart';
import 'package:globipay_admin_panel/modules/amount_section/trans_history/controller/trans_history_controller.dart';
import 'package:globipay_admin_panel/modules/amount_section/trans_history/table/trans_history_data_pager_delegate.dart';
import 'package:globipay_admin_panel/modules/amount_section/trans_history/table/trans_history_data_source.dart';
import 'package:globipay_admin_panel/modules/amount_section/user_amount/controller/user_amount_controller.dart';
import 'package:globipay_admin_panel/modules/amount_section/user_amount/table/user_amount_data_pager_delegate.dart';
import 'package:globipay_admin_panel/modules/amount_section/user_amount/table/user_amount_data_source.dart';
import 'package:globipay_admin_panel/modules/users_section/blocked_users/controller/blocked_users_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/blocked_users/table/blocked_users_data_pager_delegate.dart';
import 'package:globipay_admin_panel/modules/users_section/blocked_users/table/blocked_users_data_source.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:globipay_admin_panel/router/route_path.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class CustomColumnSizer extends ColumnSizer {
  @override
  double computeHeaderCellWidth(GridColumn column, TextStyle style) {
    style = const TextStyle(
      fontFamily: 'newyork',
      fontSize: 15,
      fontWeight: FontWeight.w900,
      color: Color(0xFF2C3E50),
    );
    return super.computeHeaderCellWidth(column, style);
  }

  @override
  double computeCellWidth(GridColumn column, DataGridRow row, Object? cellValue,
      TextStyle textStyle) {
    textStyle = const TextStyle(
      fontFamily: 'newyork',
      fontSize: 14,
      fontWeight: FontWeight.normal,
    );
    return super.computeCellWidth(column, row, cellValue, textStyle);
  }
}
class UserAmountScreenBuilder extends StatefulWidget {
  const UserAmountScreenBuilder({super.key});
  @override
  State<UserAmountScreenBuilder> createState() => _UserAmountScreenBuilderState();
}

class _UserAmountScreenBuilderState extends BaseViewState<UserAmountScreenBuilder, UserAmountController> {
  final CustomColumnSizer _customColumnSizer = CustomColumnSizer();
  late Map<String, double> columnWidths = {
    'name': double.nan,
    'email': double.nan,
    'date': double.nan,
    'coin': double.nan,
    'coin_type': double.nan,
    'category_name': double.nan,
    'edit': double.nan,
    'details': double.nan,
  };

  @override
  void initState() {
    controller.onInit();
    super.initState();
  }


  @override
  Widget body(BuildContext context) {
    return Container(
      color: AppColors.projectWhite,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Card(
          color: AppColors.projectWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header section with updated design
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
                      'User Amount',
                      style: TextStyle(
                        fontFamily: 'newyork',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.projectFontBlue,
                      ),
                    ),
                    Row(
                      children: [
                        Obx(
                          () => Text(
                            'Total Users: ${controller.totalItems}',
                            style: const TextStyle(
                              fontFamily: 'newyork',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.projectFontBlue,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          'Show entries:   ',
                          style: TextStyle(
                            fontFamily: 'newyork',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.projectFontBlue,
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
              // DataGrid section with original row settings and updated design
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Obx(
                    () => SfDataGridTheme(
                      data: SfDataGridThemeData(
                        headerColor: AppColors.projectHeaderBlue,
                      ),
                      child: SfDataGrid(
                        source: UserAmountDataSource(
                          controller.transactions.value,
                          onActionTap: (user, action) {
                            switch (action) {
                              case 'details':
                                controller.onUserDetailsClicked(user);
                                break;
                            }
                          },
                          visibleColumns: controller.visibleColumns.value,
                        ),
                        // onQueryRowHeight: (details) {
                        //   return details.getIntrinsicRowHeight(details.rowIndex);
                        // },
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
                        columnSizer: _customColumnSizer,
                        columns: _buildColumns(controller.visibleColumns.value),
                        rowHeight: 230, // Restored original row height
                        headerRowHeight: 60,
                      ),
                    ),
                  ),
                ),
              ),
              // Pagination section with updated design
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                            delegate: UserAmountDataPagerDelegate(controller),
                            pageCount: max(
                              1,
                              (controller.totalItems.value / controller.pageSize.value)
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
        ),
      ),
    );
  }

  List<GridColumn> _buildColumns(List<String> visibleColumns) {
    final columnDefinitions = {
      'name': {'title': 'Full Name', 'paddingPercent': 20},
      'email': {'title': 'Email', 'paddingPercent': 20},
      'date': {'title': 'Date', 'paddingPercent': 10},
      'coin': {'title': 'Coin', 'paddingPercent': 30},
      'coint_type': {'title': 'Status', 'paddingPercent': 10},
      'category_name': {'title': 'Level', 'paddingPercent': 10},
      'edit': {'title': 'Edit', 'paddingPercent': 30},
      'details': {'title': 'Details', 'paddingPercent': 30},
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