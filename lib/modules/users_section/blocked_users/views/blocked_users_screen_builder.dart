import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:globipay_admin_panel/core/base/base_view_state.dart';
import 'package:globipay_admin_panel/modules/users_section/blocked_users/controller/blocked_users_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/blocked_users/table/blocked_users_data_pager_delegate.dart';
import 'package:globipay_admin_panel/modules/users_section/blocked_users/table/blocked_users_data_source.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:globipay_admin_panel/router/route_path.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class BlockedUsersScreenBuilder extends StatefulWidget {
  const BlockedUsersScreenBuilder({super.key});

  @override
  State<BlockedUsersScreenBuilder> createState() =>
      _BlockedUsersScreenBuilderState();
}

class _BlockedUsersScreenBuilderState extends BaseViewState<
    BlockedUsersScreenBuilder, BlockedUsersController> {
  

  late Map<String, double> columnWidths = {
    'code': double.nan,
    'name': double.nan,
    'email': double.nan,
    'date': double.nan,
    'status': double.nan,
    'document': double.nan,

  };

  @override
  void initState() {
    controller.onInit();
    super.initState();
  }

  @override
  PreferredSizeWidget? appBar() {
    return AppBar(title: Text('Inactive Users'));
  }

  @override
  Widget body(BuildContext context) {

    return Container(
      color: const Color.fromARGB(255, 240, 238, 255),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 28, 170, 61),
                      const Color.fromARGB(255, 127, 224, 135),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Text(
                        'Total Users: ${controller.totalItems}',
                        style: TextStyle(
                          fontFamily: 'newyork',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          'Show entries:   ',
                          style: TextStyle(
                            fontFamily: 'newyork',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.white,
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
                                      style: TextStyle(
                                        fontSize: 13, // Adjust the font size
                                        fontWeight: FontWeight
                                            .bold, // Change font weight (e.g., bold)
                                        color: const Color.fromARGB(
                                            143, 0, 0, 0), // Set text color
                                        fontFamily:
                                            'newyork', // Specify a custom font family if needed
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
                  () => SfDataGrid(
                    source: BlockedUsersDataSource(
                      controller.users.value,
                      onActionTap: (user, action) {
                        switch (action) {
                          case 'document':
                            AppRoutes.pushNamed(RoutePath.userProfile);
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
              // Pagination
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 232, 236, 233),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey[300]!,
                      width: 1,
                    ),
                  ),
                ),
                child: Obx(
                  () => SfDataPagerTheme(
                    data: SfDataPagerThemeData(
                      itemColor: Colors.white, // Unselected button color
                      selectedItemColor: const Color.fromARGB(
                          164, 12, 87, 62), // Selected button color
                      itemBorderRadius: BorderRadius.circular(50),
                      backgroundColor: const Color.fromARGB(255, 232, 236, 233),
                    ),
                    child: SfDataPager(
                      delegate: BlockedUsersDataPagerDelegate(controller),
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
      ),
    );
  }

  List<GridColumn> _buildColumns(List<String> visibleColumns) {
    final columnDefinitions = {
      'code': {'title': 'Code', 'paddingPercent': 20},
      'name': {'title': 'Full Name', 'paddingPercent': 20},
      'email': {'title': 'Email', 'paddingPercent': 25},
      'date': {'title': 'Date', 'paddingPercent': 10},
      'status': {'title': 'Status', 'paddingPercent': 5},
      'document': {'title': 'document', 'paddingPercent': 5},
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
