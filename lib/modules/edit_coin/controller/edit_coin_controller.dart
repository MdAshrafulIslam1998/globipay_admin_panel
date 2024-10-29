import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/core/data/model/coin_data_model.dart';
import 'package:globipay_admin_panel/core/widgets/data_table/controller/enhanced_table_controller.dart';

class EditCoinController extends BaseController {
  final RxList<EditCoinModel> coins = <EditCoinModel>[].obs;
  final tableController = Get.put(EnhancedTableController());

  @override
  void onInit() {
    super.onInit();
    // Call fetchCoins() to initialize data
    fetchCoins();
  }

  void fetchCoins() {
    // Mock data for demonstration. Replace with actual data fetching logic.
    coins.value = [
      EditCoinModel(
        id: 1,
        fullName: 'Alice Johnson',
        email: 'alice@example.com',
        amount: {'S': 30.00, 'V': 100.00, '&': 300.00},
        status: 'Active',
      ),
      // Add more entries as needed
    ];

    tableController.initialize(getTableData(), 1);
  }

  // Retrieve data for EnhancedDataTable in the format it requires
  List<Map<String, dynamic>> getTableData() {
    return coins.map((coin) {
      return coin.toMap(
        onEditPressed: handleEditProfile,
        onViewPressed: handleViewProfile,
      );
    }).toList();
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
    // Adjust the filtering logic as per requirement
    fetchCoins();
  }

  void filterByDollar() {
    // Filter coins by dollar amount (e.g., check if amount['S'] exists and > 0)
    coins.value = coins.where((coin) => coin.amount.containsKey('S')).toList();
  }

  void filterByRupee() {
    coins.value = coins.where((coin) => coin.amount.containsKey('V')).toList();
  }

  void filterByTaka() {
    coins.value = coins.where((coin) => coin.amount.containsKey('&')).toList();
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
