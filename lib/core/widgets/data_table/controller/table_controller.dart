import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_config_model.dart';

class TableController extends BaseController {
  // Pagination
  RxInt currentPage = 1.obs;
  RxInt itemsPerPage = 10.obs;
  
  // Sorting
  RxString sortColumn = ''.obs;
  RxBool isAscending = true.obs;
  
  // Search
  RxString searchQuery = ''.obs;
  
  // Data
  RxList<dynamic> filteredData = <dynamic>[].obs;
  RxList<dynamic> originalData = <dynamic>[].obs;
  
  // Selected rows
  RxList<dynamic> selectedRows = <dynamic>[].obs;
  
  void initialize(List<dynamic> data, TableConfigModel config) {
    originalData.value = data;
    filteredData.value = data;
    itemsPerPage.value = config.defaultRowsPerPage;
  }
  
  void onSearch(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredData.value = originalData;
    } else {
      filteredData.value = originalData.where((item) {
        return item.toString().toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    currentPage.value = 1; // Reset to first page
  }
  
  void sort(String column) {
    if (sortColumn.value == column) {
      isAscending.value = !isAscending.value;
    } else {
      sortColumn.value = column;
      isAscending.value = true;
    }
    
    filteredData.sort((a, b) {
      if (!isAscending.value) {
        final temp = a;
        a = b;
        b = temp;
      }
      return a[column].toString().compareTo(b[column].toString());
    });
  }
  
  void updatePage(int page) {
    currentPage.value = page;
  }
  
  void updateItemsPerPage(int value) {
    itemsPerPage.value = value;
    currentPage.value = 1;
  }
  
  List<dynamic> getPaginatedData() {
    final startIndex = (currentPage.value - 1) * itemsPerPage.value;
    final endIndex = startIndex + itemsPerPage.value;
    return filteredData.sublist(
      startIndex,
      endIndex > filteredData.length ? filteredData.length : endIndex,
    );
  }
}
