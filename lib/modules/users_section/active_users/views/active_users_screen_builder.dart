import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:globipay_admin_panel/core/base/base_view_state.dart';
import 'package:globipay_admin_panel/modules/users_section/active_users/controller/active_users_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/active_users/table/user_data_pager_delegator.dart';
import 'package:globipay_admin_panel/modules/users_section/active_users/table/user_data_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../user.dart';

class ActiveUsersScreenBuilder extends StatefulWidget {
  const ActiveUsersScreenBuilder({super.key});

  @override
  State<ActiveUsersScreenBuilder> createState() =>
      _ActiveUsersScreenBuilderState();
}

class _ActiveUsersScreenBuilderState
    extends BaseViewState<ActiveUsersScreenBuilder, ActiveUsersController> {
  double datapagerHeight = 70.0;

  @override
  void initState() {
    controller.onInit();
    super.initState();
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Section
              Container(
                padding: const EdgeInsets.all(8),
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
                    // Total Users Count
                    Obx(
                      () => Text(
                        'Total Users: ${controller.totalItems}',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    // Page Size Selector
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
                          padding: const EdgeInsets.symmetric(horizontal: 8),
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
                                    controller.pageSize.value = newSize;
                                    controller.fetchUsers(1, newSize);
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
                    gridLinesVisibility: GridLinesVisibility.both,
                    headerGridLinesVisibility: GridLinesVisibility.both,
                    columnWidthMode: ColumnWidthMode.fill,
                    source: UserDataSource(controller.users,
                      onActionTap: (User user, String action) {
                        switch (action) {
                          case 'view':
                          // Handle view
                            break;
                          case 'edit':
                          // Handle edit
                            break;
                          case 'message':
                          // Handle message
                            break;
                        }
                      },
                    ),
                    columns: [
                      GridColumn(
                        columnName: 'id',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text(
                            'ID',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'name',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text(
                            'Name',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'designation',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text(
                            'Designation',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'age',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text(
                            'Age',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      GridColumn(
                        columnName: 'actions',
                        width: 160, // Fixed width for actions column
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text(
                            'Actions',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              // Pager
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
                    pageCount: (controller.totalItems.value /
                            controller.pageSize.value)
                        .ceilToDouble(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
