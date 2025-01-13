import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class EditCoinController extends BaseController {
  var coins = <Map<String, dynamic>>[].obs;
  var selectedPageSize = 2.obs; // Default page size is 20
  late DataPagerController dataPagerController;

  @override
  void onInit() {
    super.onInit();
    dataPagerController = DataPagerController(); // Initialize the _controller here
    fetchCoins(); // Load initial data
  }

  void fetchCoins() {
    // Simulating the data fetching based on page size
    // In a real scenario, you'd handle pagination here
    coins.assignAll([
      {
        "fullName": "Rajesh Mojumder",
        "email": "rajeshmojumder@gmail.com",
        "amount": ["30", "100", "300"],
        "level": "Level 2",
        "status": "Verified"
      },
      {
        "fullName": "Jane Doe",
        "email": "janedoe@example.com",
        "amount": ["50", "150", "250"],
        "level": "Level 1",
        "status": "Pending"
      },
      // Add other entries accordingly
    ]);
  }

  void editCoin(String userId) {
    // Handle edit coin action
  }

  void viewDetails(String userId) {
    // Handle view details action
  }
}
