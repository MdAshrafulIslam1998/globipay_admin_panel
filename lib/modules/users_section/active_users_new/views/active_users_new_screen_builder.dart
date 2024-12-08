import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:globipay_admin_panel/core/base/base_view_state.dart';
import 'package:globipay_admin_panel/modules/users_section/active_users_new/controller/active_users_new_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/active_users_new/table/user_new_data_pager_delegate.dart';
import 'package:globipay_admin_panel/modules/users_section/active_users_new/table/user_new_data_source.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:globipay_admin_panel/router/route_path.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:globipay_admin_panel/modules/role_manager.dart';

class ActiveUsersNewScreenBuilder extends StatefulWidget {
  const ActiveUsersNewScreenBuilder({super.key});

  @override
  State<ActiveUsersNewScreenBuilder> createState() =>
      _ActiveUsersNewScreenBuilderState();
}

class _ActiveUsersNewScreenBuilderState extends BaseViewState<
    ActiveUsersNewScreenBuilder, ActiveUsersNewController> {
  final String currentRole = RoleManager.manager; // Example role
  late List<String> visibleColumns;

  @override
  void initState() {
    controller.onInit();
    super.initState();
  }

  @override
  PreferredSizeWidget? appBar() {
    return AppBar(title: Text('Active Users New'));
  }

  @override
  Widget body(BuildContext context) {
    final visibleColumns = RoleManager.getVisibleColumns(currentRole); // Get columns for the role

    return Container(
      color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Text(
                        'Total Users: ${controller.totalItems}',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Entries per page: ',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 1,
                            ),
                          ),
                          child: Obx(() => DropdownButton<int>(
                                value: controller.pageSize.value,
                                underline: Container(),
                                items: [5, 10, 20, 30].map((size) {
                                  return DropdownMenuItem<int>(
                                    value: size,
                                    child: Text(size.toString()),
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
              Expanded(
                child: Obx(
                  () => SfDataGrid(
                    columnWidthMode: ColumnWidthMode.fill,
                    source: UserDataSource(
                      controller.users,
                      onActionTap: (user, action) {
                        switch (action) {
                          case 'details':
                            AppRoutes.pushNamed(RoutePath.pendingProfile);
                            break;
                          case 'delete':
                            print('Delete action for ${user.name}');
                            break;
                          case 'message':
                            print('Message action for ${user.name}');
                            break;
                        }
                      },
                       visibleColumns: visibleColumns,
                    ),
                    gridLinesVisibility: GridLinesVisibility.both,
                    headerGridLinesVisibility: GridLinesVisibility.both,
                    columns: _buildColumns(visibleColumns),
                    rowHeight: 50,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey[300]!,
                      width: 1,
                    ),
                  ),
                ),
                child: Obx(
                  () => SfDataPager(
                    delegate: UserDataPagerDelegate(controller),
                    pageCount: max(
                      1,
                      (controller.totalItems.value / controller.pageSize.value)
                          .ceilToDouble(),
                    ), // Ensure minimum pageCount is 1
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
      'name': 'Full Name',
      'email': 'Email',
      'primary': 'Primary',
      'secondary': 'Secondary',
      'levelName': 'Level',
      'date': 'Date',
      'status': 'Status',
      'details': 'Details',
      'delete': 'Delete',
      'message': 'Message',
    };

    return visibleColumns.map((colName) {
      return GridColumn(
        columnName: colName,
        label: _buildHeaderCell(columnDefinitions[colName] ?? colName),
        width: _getColumnWidth(colName),
      );
    }).toList();
  }

  double _getColumnWidth(String columnName) {
    switch (columnName) {
      case 'levelName':
        return 100;
      case 'date':
        return 220;
      case 'status':
        return 100;
      case 'details':
      case 'delete':
      case 'message':
        return 80;
      default:
        return 80.0;
    }
  }

  Widget _buildHeaderCell(String text) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Color(0xFF2C3E50),
        ),
      ),
    );
  }
}
