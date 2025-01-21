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
import 'package:globipay_admin_panel/modules/users_section/blocked_users/controller/blocked_users_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/blocked_users/table/blocked_users_data_pager_delegate.dart';
import 'package:globipay_admin_panel/modules/users_section/blocked_users/table/blocked_users_data_source.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:globipay_admin_panel/router/route_path.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
class TransactionHistoryScreenBuilder extends StatefulWidget {
  const TransactionHistoryScreenBuilder({super.key});
  @override
  State<TransactionHistoryScreenBuilder> createState() =>
      _TransactionHistoryScreenBuilderState();
}

class _TransactionHistoryScreenBuilderState extends BaseViewState<
    TransactionHistoryScreenBuilder, TransHistoryController> {
  late Map<String, double> columnWidths = {
    'name': double.nan,
    'email': double.nan,
    'date': double.nan,
    'coin': double.nan,
    'coin_type': double.nan,
    'category_name': double.nan,
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
                      'Transaction History',
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
              // Filter buttons section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(Icons.ac_unit,
                        color: Colors.black54,

                      ),
                      label: Text('All'),
                      onPressed: () {
                        controller.fetchAllTransactions(
                            1, controller.pageSize.value);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[100],
                        foregroundColor: Colors.green[800],
                      ),
                    ),
                    AppSpaces.horizontalSpace,

                    ElevatedButton.icon(
                      icon: Icon(Icons.person,
                      color: Colors.black54,
                      ),
                      label: Text('User'),
                      onPressed: () {
                        controller.fetchUserWiseTransactionHistory(
                            1, controller.pageSize.value);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[100],
                        foregroundColor: Colors.green[800],
                      ),
                    ),
                    AppSpaces.horizontalSpace,
                    ElevatedButton.icon(
                      icon: Icon(Icons.category_outlined,
                        color: Colors.black54,
                      ),
                      label: Text('Category'),
                      onPressed: () {
                        controller.setCategorySelectionVisibility(
                          !controller.isCategorySelectionVisible.value,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[100],
                        foregroundColor: Colors.green[800],
                      ),
                    ),
                    Obx(
                      () => Visibility(
                        visible: controller.isCategorySelectionVisible.value,
                        child: IntrinsicWidth(
                          child: Container(
                            height: 40,
                            margin: const EdgeInsets.only(left: 12),
                            decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            child:DropdownButtonFormField<CategoryItemEntity>(
                              isExpanded: true,
                            value: controller.selectedCategory.value,
                            hint: Text('Select'),
                            onChanged: (CategoryItemEntity? newValue) {
                              controller.setSelectedCategory(newValue);
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.projectBlue.withOpacity(0.1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12),
                            ),
                            items: controller.categoriesList.map((CategoryItemEntity item) {
                              return DropdownMenuItem<CategoryItemEntity>(
                                value: item,
                                child: Text(item.name ?? "Unknown",overflow: TextOverflow.ellipsis,),
                              );
                            }).toList(),
                                                      ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // DataGrid section with updated design
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Obx(
                    () => SfDataGridTheme(
                      data: SfDataGridThemeData(
                        headerColor: AppColors.projectHeaderBlue,
                      ),
                      child: SfDataGrid(
                        source: TransHistoryDataSource(
                          controller.transactions.value,
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
                        rowHeight: double.nan, // This enables auto row height
                        headerRowHeight: 60,
                        onQueryRowHeight: (details) {
                          return details.getIntrinsicRowHeight(details.rowIndex);
                        },

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
                            delegate: TransHistoryDataPagerDelegate(controller),
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
      'email': {'title': 'Email', 'paddingPercent': 25},
      'date': {'title': 'Date', 'paddingPercent': 10},
      'coin': {'title': 'Coin', 'paddingPercent': 5},
      'coin_type': {'title': 'Coin Type', 'paddingPercent': 5},
      'category_name': {'title': 'Brand', 'paddingPercent': 5},
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