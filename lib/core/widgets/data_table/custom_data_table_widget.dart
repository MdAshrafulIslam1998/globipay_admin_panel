import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_column_model.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_config_model.dart';
import 'package:globipay_admin_panel/core/data/model/pagination.dart';
import 'package:globipay_admin_panel/core/widgets/data_table/table_header_widget.dart';
import 'package:globipay_admin_panel/core/widgets/data_table/table_pagination_widget.dart';

class CustomDataTableWidget extends StatelessWidget {
  final List<TableColumnModel> columns;
  final RxList<Map<String, dynamic>> data;
  final TableConfigModel config;
  final Map<String, Widget Function(dynamic)>? customBuilders;
  final Function(String)? onSearch;
  final Function(int)? onPageChange;
  final Function(String, bool)? onSort;
  final Function(Map<String, dynamic>)? onView;
  final Function(Map<String, dynamic>)? onDelete;
  final Function(Map<String, dynamic>)? onChat;

  final RxString _searchQuery = ''.obs;
  final RxInt _currentPage = 1.obs;
  final RxString _sortColumn = ''.obs;
  final RxBool _sortAscending = true.obs;

  CustomDataTableWidget({
    Key? key,
    required this.columns,
    required this.data,
    required this.config,
    this.customBuilders,
    this.onSearch,
    this.onPageChange,
    this.onSort,
    this.onView,
    this.onDelete,
    this.onChat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Obx(() => TableHeaderWidget(
              config: config,
              searchQuery: _searchQuery,
              onEntriesChanged: (value) {
                // Handle entries change
              },
              onSearch: (value) {
                _searchQuery.value = value;
                onSearch?.call(value);
              },
            )),
        const SizedBox(height: 16),
        Obx(() => _buildDataTable()),
        Obx(() => _buildPagination()),
      ],
    );
  }

  Widget _buildDataTable() {
    // Assuming table implementation is yet to be done
    // Return a placeholder widget temporarily
    return const SizedBox(); // or any placeholder widget
  }

  Widget _buildPagination() {
    final pagination = Pagination(
      currentPage: _currentPage.value,
      totalPages: (data.length / config.rowsPerPage).ceil(),
      total: data.length,
      limit: config.rowsPerPage,
    );

    return TablePaginationWidget(
      pagination: pagination,
      onPageChange: (page) {
        _currentPage.value = page;
        onPageChange?.call(page);
      },
    );
  }
}
