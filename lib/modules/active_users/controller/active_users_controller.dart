import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';

class ActiveUsersController extends BaseController {
  var coins = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCoins(); // Load initial data
  }

  void fetchCoins() {
    // Fetch data and populate coins
    coins.assignAll([
      {
        "fullName": "Rajesh Mojumder",
        "email": "rajeshmojumder@gmail.com",
        "amount": ["30", "100", "300"],
        "level": "Level 2",
        "status": "Verified"
      },
      // Add other entries similarly
    ]);
  }

  void editCoin(String userId) {
    // Handle edit coin action
  }

  void viewDetails(String userId) {
    // Handle view details action
  }
}
