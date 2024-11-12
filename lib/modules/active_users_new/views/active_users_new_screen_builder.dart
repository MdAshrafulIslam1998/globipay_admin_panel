import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:globipay_admin_panel/core/base/base_view_state.dart';
import 'package:globipay_admin_panel/modules/active_users_new/controller/active_users_new_controller.dart';
import 'package:globipay_admin_panel/modules/active_users_new/table/user_new_data_pager_delegate.dart';
import 'package:globipay_admin_panel/modules/active_users_new/table/user_new_data_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ActiveUsersNewScreenBuilder extends StatefulWidget {
  const ActiveUsersNewScreenBuilder({super.key});

  @override
  State<ActiveUsersNewScreenBuilder> createState() =>
      _ActiveUsersNewScreenBuilderState();
}

class _ActiveUsersNewScreenBuilderState extends BaseViewState<
    ActiveUsersNewScreenBuilder, ActiveUsersNewController> {
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
                                items: [10, 20, 30].map((size) {
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
                  () => ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.7,
                    ),
                    child: SfDataGrid(
                      gridLinesVisibility: GridLinesVisibility.both,
                      headerGridLinesVisibility: GridLinesVisibility.both,
                      columnWidthMode: ColumnWidthMode.fill,
                      source: UserDataSource(
                        controller.users,
                        onActionTap: (user, action) {
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
                          columnName: 'userId',
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
                          columnName: 'email',
                          label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Email',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        GridColumn(
                          columnName: 'amount',
                          label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Amount',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        GridColumn(
                          columnName: 'levelName',
                          label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Level',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        GridColumn(
                          columnName: 'status',
                          label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Status',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        GridColumn(
                          columnName: 'date',
                          label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Date',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        GridColumn(
                          columnName: 'actions',
                          width: 160,
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
                      rowHeight: 50,
                    ),
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
