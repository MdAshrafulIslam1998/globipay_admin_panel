// 4. transaction_history_screen_builder.dart
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:globipay_admin_panel/core/base/base_view_state.dart';
import 'package:globipay_admin_panel/modules/amount_section/trans_history/controller/trans_history_controller.dart';
import 'package:globipay_admin_panel/modules/amount_section/trans_history/table/trans_history_data_pager_delegate.dart';
import 'package:globipay_admin_panel/modules/amount_section/trans_history/table/trans_history_data_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'dart:math';

class TransactionHistoryScreenBuilder extends StatefulWidget {
  const TransactionHistoryScreenBuilder({super.key});

  @override
  State<TransactionHistoryScreenBuilder> createState() =>
      _TransactionHistoryScreenBuilderState();
}

class _TransactionHistoryScreenBuilderState extends BaseViewState<
    TransactionHistoryScreenBuilder, TransactionHistoryController> {
  @override
  void initState() {
    controller.onInit();
    super.initState();
  }

  @override
  PreferredSizeWidget? appBar() {
    return AppBar(title: Text('Transaction History'));
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
                        'Total Transactions: ${controller.totalItems}',
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
                    source: TransactionDataSource(controller.transactions),
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
                        columnName: 'date',
                        label: _buildHeaderCell('Date'),
                        width: 120,
                      ),
                      GridColumn(
                        columnName: 'coin',
                        label: _buildHeaderCell('Amount'),
                        width: 100,
                      ),
                      GridColumn(
                        columnName: 'categoryName',
                        label: _buildHeaderCell('Brand'),
                        width: 120,
                      ),
                      GridColumn(
                        columnName: 'coinType',
                        label: _buildHeaderCell('Type'),
                        width: 300,
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
                    delegate: TransHistoryDataPagerDelegate(controller),
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