import 'dart:math';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';

class EnhancedTableController extends BaseController {
  // Observable variables
  final RxInt currentPage = 1.obs;
  final RxInt itemsPerPage = 10.obs;
  final RxString sortColumn = ''.obs;
  final RxBool isAscending = true.obs;
  final RxString searchQuery = ''.obs;
  final RxList<dynamic> filteredData = <dynamic>[].obs;
  final RxList<dynamic> displayData = <dynamic>[].obs;
  final RxInt totalPages = 1.obs;

  // Original data
  List<dynamic> originalData = [];

  void initialize(List<dynamic> data, int defaultItemsPerPage) {
    originalData = data;
    itemsPerPage.value = defaultItemsPerPage;
    _updateFilteredData();
    _updateTotalPages();
  }

  void onSearch(String query) {
    searchQuery.value = query;
    currentPage.value = 1;
    _updateFilteredData();
    _updateTotalPages();
  }

  void onSort(String column) {
    if (sortColumn.value == column) {
      isAscending.toggle();
    } else {
      sortColumn.value = column;
      isAscending.value = true;
    }
    _updateFilteredData();
  }

  void onPageChanged(int page) {
    currentPage.value = page;
    _updateDisplayData();
  }

  void onItemsPerPageChanged(int value) {
    itemsPerPage.value = value;
    currentPage.value = 1;
    _updateTotalPages();
    _updateDisplayData();
  }

  void _updateFilteredData() {
    var data = List<dynamic>.from(originalData);

    // Apply search
    if (searchQuery.isNotEmpty) {
      data = data.where((item) {
        return item
            .toString()
            .toLowerCase()
            .contains(searchQuery.value.toLowerCase());
      }).toList();
    }

    // Apply sort
    if (sortColumn.isNotEmpty) {
      data.sort((a, b) {
        var comparison = a[sortColumn.value]
            .toString()
            .compareTo(b[sortColumn.value].toString());
        return isAscending.value ? comparison : -comparison;
      });
    }

    filteredData.value = data;
    _updateDisplayData();
  }

  void _updateDisplayData() {
    final startIndex = (currentPage.value - 1) * itemsPerPage.value;
    final endIndex = min(startIndex + itemsPerPage.value, filteredData.length);

    if (startIndex < filteredData.length) {
      displayData.value = filteredData.sublist(startIndex, endIndex);
    } else {
      displayData.value = [];
    }
  }

  void _updateTotalPages() {
    totalPages.value = (filteredData.length / itemsPerPage.value).ceil();
    if (currentPage.value > totalPages.value && totalPages.value > 0) {
      currentPage.value = totalPages.value;
    }
  }

  List<Map<String, dynamic>> exportCurrentData() {
    return filteredData.map((item) => Map<String, dynamic>.from(item)).toList();
  }
}
