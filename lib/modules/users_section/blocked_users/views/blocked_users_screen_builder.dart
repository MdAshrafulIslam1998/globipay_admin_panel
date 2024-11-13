import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:globipay_admin_panel/core/base/base_view_state.dart';
import 'package:globipay_admin_panel/modules/users_section/blocked_users/controller/blocked_users_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/blocked_users/table/blocked_users_data_pager_delegate.dart';
import 'package:globipay_admin_panel/modules/users_section/blocked_users/table/blocked_users_data_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class BlockedUsersScreenBuilder extends StatefulWidget {
  const BlockedUsersScreenBuilder({super.key});

  @override
  State<BlockedUsersScreenBuilder> createState() =>
      _BlockedUsersScreenBuilderState();
}

class _BlockedUsersScreenBuilderState
    extends BaseViewState<BlockedUsersScreenBuilder, BlockedUsersController> {
  @override
  void initState() {
    controller.onInit();
    super.initState();
  }

  @override
  PreferredSizeWidget? appBar() {
    return AppBar(title: Text('Blocked Users'));
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
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Text(
                        'Total Blocked Users: ${controller.totalItems}',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Show entries: ',
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
                    source: BlockedUserDataSource(
                      controller.users,
                      onActionTap: (user, action) {
                        switch (action) {
                          case 'document':
                            print('document action for ${user.name}');
                            break;
                        }
                      },
                    ),
                    gridLinesVisibility: GridLinesVisibility.both,
                    headerGridLinesVisibility: GridLinesVisibility.both,
                    columnWidthMode: ColumnWidthMode.fill,
                    columns: [
                      GridColumn(
                        columnName: 'fullName',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text(
                            'Full Name',
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
                        columnName: 'document',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text(
                            'Document',
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
                    delegate: BlockedUserDataPagerDelegate(controller),
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
}
