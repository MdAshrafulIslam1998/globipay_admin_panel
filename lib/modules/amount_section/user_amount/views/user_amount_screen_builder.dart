import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:globipay_admin_panel/core/base/base_view_state.dart';
import 'package:globipay_admin_panel/modules/amount_section/user_amount/controller/user_amount_controller.dart';
import 'package:globipay_admin_panel/modules/amount_section/user_amount/table/user_amount_data_pager_delegate.dart';
import 'package:globipay_admin_panel/modules/amount_section/user_amount/table/user_amount_data_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UserAmountScreenBuilder extends StatefulWidget {
  const UserAmountScreenBuilder({super.key});

  @override
  State<UserAmountScreenBuilder> createState() =>
      _UserAmountScreenBuilderState();
}

class _UserAmountScreenBuilderState
    extends BaseViewState<UserAmountScreenBuilder, UserAmountController> {
  @override
  void initState() {
    controller.onInit();
    super.initState();
  }

  @override
  PreferredSizeWidget? appBar() {
    return AppBar(title: const Text('User Amounts'));
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
                        'Total Users: ${controller.totalItems}',
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
              // DataGrid
              Expanded(
                child: Obx(
                  () => SfDataGrid(
                    source: UserAmountDataSource(
                      controller.users,
                      onActionTap: (user, action) {
                        print('$action button clicked for ${user.name}');
                      },
                    ),
                    gridLinesVisibility: GridLinesVisibility.both,
                    headerGridLinesVisibility: GridLinesVisibility.both,
                    columnWidthMode: ColumnWidthMode.fill,
                    onQueryRowHeight: (RowHeightDetails details) {
                      if (details.rowIndex == 0) {
                        // Return a fixed height for the header row.
                        return 56.0;
                      } else {
                        // Measure height based on the tallest cell content
                        var rowData = controller.users[details.rowIndex - 1];
                        var amountLines = rowData
                            .amount.length; // Total categories in 'amount'
                        var baseHeight = 40.0; // Base row height
                        var lineHeight =
                            20.0; // Approximate line height for each category line

                        // Calculate dynamic height based on number of lines in the 'amount' cell
                        return baseHeight + (amountLines * lineHeight);
                      }
                    },
                    columns: [
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
                        columnName: 'level',
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
                        columnName: 'edit',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text(
                            'Edit',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'details',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text(
                            'Details',
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
                    delegate: UserAmountDataPagerDelegate(controller),
                    pageCount: max(
                      1,
                      (controller.totalItems.value / controller.pageSize.value)
                          .ceilToDouble(),
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
}
