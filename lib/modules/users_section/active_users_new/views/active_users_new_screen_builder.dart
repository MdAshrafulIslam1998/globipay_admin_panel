import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:globipay_admin_panel/core/base/base_view_state.dart';
import 'package:globipay_admin_panel/modules/users_section/active_users_new/controller/active_users_new_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/active_users_new/table/user_new_data_pager_delegate.dart';
import 'package:globipay_admin_panel/modules/users_section/active_users_new/table/user_new_data_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ActiveUsersNewScreenBuilder extends StatefulWidget {
  const ActiveUsersNewScreenBuilder({super.key});

  @override
  State<ActiveUsersNewScreenBuilder> createState() =>
      _ActiveUsersNewScreenBuilderState();
}


class _ActiveUsersNewScreenBuilderState extends BaseViewState<
    ActiveUsersNewScreenBuilder, ActiveUsersNewController> {
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
              Expanded(
                child: Obx(
                  () => SfDataGrid(
                    columnWidthMode: ColumnWidthMode.fill,
                    source: UserDataSource(
                      controller.users,
                      onActionTap: (user, action) {
                        switch (action) {
                          case 'details':
                            print('Details action for ${user.name}');
                            break;
                          case 'delete':
                            print('Delete action for ${user.name}');
                            break;
                          case 'message':
                            print('Message action for ${user.name}');
                            break;
                        }
                      },
                    ),
                    gridLinesVisibility: GridLinesVisibility.both,
                    headerGridLinesVisibility: GridLinesVisibility.both,
                    columns: [
                      GridColumn(
                        columnName: 'name',
                        label: _buildHeaderCell('Full Name'),
                      ),
                      GridColumn(
                        columnName: 'email',
                        label: _buildHeaderCell('Email'),
                      ),
                      GridColumn(
                        columnName: 'primary',
                        label: _buildHeaderCell('Primary'),
                      ),
                      GridColumn(
                        columnName: 'secondary',
                        label: _buildHeaderCell('Secondary'),
                      ),
                      GridColumn(
                        columnName: 'levelName',
                        label: _buildHeaderCell('Level'),
                        width: 100,
                      ),
                      GridColumn(
                        columnName: 'date',
                        label: _buildHeaderCell('Date'),
                        width: 120,
                      ),
                      GridColumn(
                        columnName: 'status',
                        label: _buildHeaderCell('Status'),
                        width: 100,
                      ),
                      GridColumn(
                        columnName: 'details',
                        label: _buildHeaderCell('Details'),
                        width: 80,
                      ),
                      GridColumn(
                        columnName: 'delete',
                        label: _buildHeaderCell('Delete'),
                        width: 80,
                      ),
                      GridColumn(
                        columnName: 'message',
                        label: _buildHeaderCell('Message'),
                        width: 80,
                      ),
                    ],
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
                    (controller.totalItems.value / controller.pageSize.value).ceilToDouble(),
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