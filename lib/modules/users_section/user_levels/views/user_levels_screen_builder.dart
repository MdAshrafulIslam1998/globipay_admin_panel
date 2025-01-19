import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:globipay_admin_panel/core/base/base_view_state.dart';
import 'package:globipay_admin_panel/core/constants/enum/table_name.dart';
import 'package:globipay_admin_panel/core/constants/table_header_visibility.dart';
import 'package:globipay_admin_panel/modules/users_section/user_levels/controller/user_levels_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/user_levels/table/user_levels_data_pager_delegate.dart';
import 'package:globipay_admin_panel/modules/users_section/user_levels/table/user_levels_data_source.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:globipay_admin_panel/router/route_path.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class UserLevelsScreenBuilder extends StatefulWidget {
  const UserLevelsScreenBuilder({super.key});
  @override
  State<UserLevelsScreenBuilder> createState() => _UserLevelsScreenBuilderState();
}

class _UserLevelsScreenBuilderState extends BaseViewState<UserLevelsScreenBuilder, UserLevelsController> {
  late Map<String, double> columnWidths = {
    'name': double.nan,
    'email': double.nan,
    'primary': double.nan,
    'secondary': double.nan,
    'levelName': double.nan,
    'date': double.nan,
    'status': double.nan,
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
      color: const Color(0xFFFFFFFF),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFFF4F7FF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'User Levels',
                      style: TextStyle(
                        fontFamily: 'newyork',
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            AppRoutes.pushNamed(RoutePath.addLevel);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFF2C3E50),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            '+ Add New Level',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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
                            color: Color(0xFF2C3E50),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Obx(
                    () => SfDataGridTheme(
                      data: SfDataGridThemeData(
                        headerColor: const Color(0xFFEDF7ED),
                      ),
                      child: SfDataGrid(
                        source: UserLevelsDataSource(
                          controller.users.value,
                          onActionTap: (user, action) {
                            switch (action) {
                              case 'details':
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
                        'Total Users: ${controller.totalItems}',
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
                            delegate: UserLevelsDataPagerDelegate(controller),
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
        ),
      ),
    );
  }

  List<GridColumn> _buildColumns(List<String> visibleColumns) {
    final columnDefinitions = {
      'name': {'title': 'Full Name', 'paddingPercent': 20},
      'email': {'title': 'Email', 'paddingPercent': 25},
      'primary': {'title': 'Primary', 'paddingPercent': 10},
      'secondary': {'title': 'Secondary', 'paddingPercent': 10},
      'levelName': {'title': 'Level', 'paddingPercent': 10},
      'date': {'title': 'Date', 'paddingPercent': 10},
      'status': {'title': 'Status', 'paddingPercent': 5},
      'details': {'title': 'Details', 'paddingPercent': 5},
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