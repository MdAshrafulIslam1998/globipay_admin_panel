import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/core/data/model/coin_data_model.dart';
import 'package:globipay_admin_panel/core/widgets/data_table/controller/enhanced_table_controller.dart';

class EditCoinController extends BaseController {
  final RxList<EditCoinModel> coins = <EditCoinModel>[].obs;
  final tableController = Get.put(EnhancedTableController());
  var tableData = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    requestForCoin();
  }


  void generateTableData(List<EditCoinModel> coins) {
    tableData.value = coins.map((coin) {
      return coin.toMap(
        onEditPressed: handleEditProfile,
        onViewPressed: handleViewProfile,
      );
    }).toList();

    tableController.initialize(tableData, 10);

  }

  void requestForCoin() {
    // TODO implement coin request logic
    // TODO For Dummy purpose

    var list = <EditCoinModel>[];
    for (var i = 0; i < 100; i++) {
      list.add(
        EditCoinModel(
          id: 1,
          fullName: 'Alice Johnson $i',
          email: 'alice@example.com',
          amount: {'S': 30.00 + i, 'V': 100.00 + i, '&': 300.00 + i},
          status: 'Active',
        ),
      );
    }
    coins.value = list;
    generateTableData(list);
  }


  // Action handlers for Edit and View profile
  void handleEditProfile(int id) {
    // Implement profile editing logic for a coin with the given id
    print("Edit profile for coin with id: $id");
  }

  void handleViewProfile(int id) {
    // Implement profile viewing logic for a coin with the given id
    print("View profile for coin with id: $id");
  }

  // Filters for All, Dollar, Rupee, Taka
  void filterAll() {
    requestForCoin();
  }

  void filterByDollar() {
    // Filter coins by dollar amount (e.g., check if amount['S'] exists and > 0)
    coins.value = coins.where((coin) => coin.amount.containsKey('S')).toList();
    generateTableData(coins);
  }

  void filterByRupee() {
    coins.value = coins.where((coin) => coin.amount.containsKey('V')).toList();
    generateTableData(coins);

  }

  void filterByTaka() {
    coins.value = coins.where((coin) => coin.amount.containsKey('&')).toList();
    generateTableData(coins);
  }

  // Export functions for Excel and PDF
  void exportToExcel() {
    // Implement Excel export logic here
    print("Exporting data to Excel");
  }

  void exportToPDF() {
    // Implement PDF export logic here
    print("Exporting data to PDF");
  }
}
