import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_column_model.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_config_model.dart';

class ActiveUsersController extends BaseController {
  final RxList<Map<String, dynamic>> users = <Map<String, dynamic>>[].obs;
  final RxBool isLoading = false.obs;

  final tableConfig = TableConfigModel(
    rowsPerPage: 10,
    showActions: true,
    showSearch: true,
    showExport: true,
  );

  final List<TableColumnModel> columns = [
    TableColumnModel(key: 'fullName', label: 'Full Name', sortable: true),
    TableColumnModel(key: 'email', label: 'Email', sortable: true),
    TableColumnModel(key: 'amount', label: 'Amount', sortable: true),
    TableColumnModel(key: 'level', label: 'Level', sortable: true),
    TableColumnModel(key: 'date', label: 'Date', sortable: true),
    TableColumnModel(key: 'status', label: 'Status'),
  ];

  final Map<String, Widget Function(dynamic)> customBuilders = {
    'amount': (value) => Text('\$ ${(value as num).toStringAsFixed(2)}'),
    'status': (value) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: value == 'active' ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(value.toString(), style: const TextStyle(color: Colors.white)),
    ),
  };

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      // API call here
      users.value = [/* your data */];
    } finally {
      isLoading.value = false;
    }
  }

  void handleSearch(String query) {
    // Implement search
  }

  void handleSort(String column, bool ascending) {
    // Implement sort
  }

  void handlePageChange(int page) {
    // Implement pagination
  }
}