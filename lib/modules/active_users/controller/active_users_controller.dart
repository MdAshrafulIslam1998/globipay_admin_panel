import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_action_model.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_column_model.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_config_model.dart';

class ActiveUsersController extends BaseController {
  // 20 Demo records to create 4 pages of data with 5 rows per page
  final List<Map<String, dynamic>> demoData = List.generate(20, (index) {
    return {
      "name": "User $index",
      "email": "user$index@example.com",
      "status": index % 2 == 0 ? "Active" : "Inactive",
    };
  });

  // Define columns for the table
  final List<TableColumnModel> columns = [
    TableColumnModel(label: "Name", key: "name"),
    TableColumnModel(label: "Email", key: "email"),
    TableColumnModel(label: "Status", key: "status"),
  ];

  // Define action buttons (optional)
  final List<TableActionModel> actions = [
    TableActionModel(label: "Edit", key: "edit"),
    TableActionModel(label: "Delete", key: "delete"),
  ];

  // Config for the table (pagination, search, etc.)
  final TableConfigModel tableConfig = TableConfigModel(
    showSearch: true,
    showPagination: true,
    rowsPerPageOptions: [5, 10, 15],
    defaultRowsPerPage: 5, // Set default rows per page to 5 for 4 pages
  );

  // Initialize filteredData and originalData for pagination and search
  late RxList<Map<String, dynamic>> filteredData;
  late RxList<Map<String, dynamic>> originalData;

  @override
  void onInit() {
    super.onInit();
    originalData = RxList(demoData);
    filteredData = RxList(demoData);
  }

  // Handle search input
  void onSearch(String query) {
    if (query.isEmpty) {
      filteredData.value = originalData;
    } else {
      filteredData.value = originalData.where((item) {
        return item['name']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
    }
  }

  // Handle action button presses (optional)
  void onActionPressed(String actionKey, dynamic rowData) {
    // Process the action based on actionKey, e.g., 'edit' or 'delete'
    if (rowData is Map<String, dynamic>) {
      // Implement specific action behavior here
    }
  }
}
