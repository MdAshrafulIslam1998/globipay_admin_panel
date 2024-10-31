import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/cell_button_model.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_button_model.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_column_model.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_pagination_model.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_search_model.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_title_model.dart';
import 'package:globipay_admin_panel/core/widgets/data_table/components/cell_button.dart';
import 'package:globipay_admin_panel/core/widgets/data_table/components/table_action_button.dart';
import 'package:globipay_admin_panel/core/widgets/data_table/components/table_divider.dart';
import 'package:globipay_admin_panel/core/widgets/data_table/components/table_entries_selector.dart';
import 'package:globipay_admin_panel/core/widgets/data_table/components/table_header_cell.dart';
import 'package:globipay_admin_panel/core/widgets/data_table/components/table_pagination.dart';
import 'package:globipay_admin_panel/core/widgets/data_table/components/table_search.dart';
import 'package:globipay_admin_panel/core/widgets/data_table/components/table_title.dart';
import 'package:globipay_admin_panel/core/widgets/data_table/controller/enhanced_table_controller.dart';

class EnhancedDataTable extends StatelessWidget {
  final String title;
  final List<TableColumnModel> columns;
  final List<dynamic> data;
  final List<int> entriesOptions;
  final List<TableButtonModel> exportButtons;
  final TableSearchModel searchModel;
  final TablePaginationModel paginationModel;
  final EnhancedTableController controller;

  EnhancedDataTable({
    Key? key,
    required this.title,
    required this.columns,
    required this.data,
    this.entriesOptions = const [10, 25, 50, 100],
    this.exportButtons = const [],
    TableSearchModel? searchModel,
    TablePaginationModel? paginationModel,
    required this.controller,
  })  :
        this.searchModel = searchModel ?? const TableSearchModel(),
        this.paginationModel = paginationModel ?? const TablePaginationModel(),
        super(key: key) {
    controller.initialize(data, entriesOptions.first);
  }
// In EnhancedDataTable widget
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title Section
            TableTitle(model: TableTitleModel(title: title)),

            const TableDivider(),

            // Controls Section - entries selector, export buttons, and search bar on the same row
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Entries Selector
                  Obx(() => TableEntriesSelector(
                        options: entriesOptions,
                        value: controller.itemsPerPage.value,
                        onChanged: controller.onItemsPerPageChanged,
                      )),

                  // Export Buttons
                  Row(
                    children: exportButtons
                        .map((button) => Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: TableActionButton(model: button),
                            ))
                        .toList(),
                  ),

                  // Search Bar (aligned to the right)
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TableSearch(
                        model: searchModel,
                        onSearch: controller.onSearch,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const TableDivider(),

            // Table Section
            // Inside EnhancedDataTable

            Expanded(
              child: SingleChildScrollView(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Obx(() {
                    return DataTable(
                      columns: columns
                          .map((column) => DataColumn(
                                label: TableHeaderCell(
                                  text: column.label,
                                  sortable: column.sortable,
                                  isActive:
                                      controller.sortColumn.value == column.key,
                                  isAscending: controller.isAscending.value,
                                  onSort: column.sortable
                                      ? () => controller.onSort(column.key)
                                      : null,
                                ),
                              ))
                          .toList(),
                      // Inside DataRow creation
                      rows: controller.displayData.map((row) {
                        return DataRow(
                          cells: columns.map((column) {
                            final value = row[column.key];
                            if (value is CellButtonModel) {
                              return DataCell(CellButton(
                                  model:
                                      value)); // This should render the button
                            }
                            return DataCell(Text(value?.toString() ?? ''));
                          }).toList(),
                        );
                      }).toList(),
                    );
                  }),
                ),
              ),
            ),

            // Pagination and Info
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() {
                    final start = (controller.currentPage.value - 1) *
                            controller.itemsPerPage.value +
                        1;
                    final end = min(start + controller.itemsPerPage.value - 1,
                        controller.filteredData.length);
                    final total = controller.filteredData.length;
                    return Text(
                      'Showing $start to $end of $total entries',
                      style: const TextStyle(
                        color: Color(0xFF4A5568),
                        fontSize: 14,
                      ),
                    );
                  }),
                  Obx(() => TablePagination(
                        model: paginationModel,
                        currentPage: controller.currentPage.value,
                        totalPages: controller.totalPages.value,
                        onPageChanged: controller.onPageChanged,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
