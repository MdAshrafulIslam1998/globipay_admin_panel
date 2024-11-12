import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/modules/blocked_users/blocked_user.dart';
import 'package:globipay_admin_panel/modules/blocked_users/blocked_user_response.dart';

class BlockedUsersController extends BaseController {
  var users = <BlockedUser>[].obs;
  var totalItems = 0.obs;
  var currentPage = 1.obs;
  var pageSize = 10.obs;
  var isLoading = false.obs;

  Future<void> fetchUsers(int page, int limit) async {
    try {
      isLoading.value = true;

      // Mock response data
      var mockResponse = {
        "responseCode": "S100000",
        "responseMessage": "User list fetched successfully",
        "data": {
          "users": [
            {
              "user_id": "8f9a0b1c-2345-67de-8901-abcdef234567",
              "name": "Erfder",
              "email": "sdadasd@gmail.com",
              "amount": 150.00,
              "level_id": 3,
              "level_name": "level 3",
              "status": "Blocked",
              "date": "2024-09-09T03:04:15.000Z"
            },
            {
              "user_id": "9b0c1d2e-3456-78ef-9012-bcdef3456789",
              "name": "Jaamal",
              "email": "ardsddsfdasden04@gmail.com",
              "amount": 400.00,
              "level_id": 5,
              "level_name": "level 5",
              "status": "Blocked",
              "date": "2024-09-05T03:50:52.000Z"
            }
          ],
          "pagination": {
            "total": 2,
            "total_pages": 1,
            "current_page": 1,
            "limit": 10
          }
        }
      };

      var userResponse = BlockedUserResponse.fromJson(mockResponse);

      // Ensure we have valid data
      if (userResponse.users.isNotEmpty) {
        users.assignAll(userResponse.users);
        totalItems.value = userResponse.pagination.total;
        currentPage.value = userResponse.pagination.currentPage;
      } else {
        // Handle empty response
        users.clear();
        totalItems.value = 0;
        currentPage.value = 1;
      }
    } catch (e) {
      print("Error fetching blocked users: $e");
      // Handle error state
      users.clear();
      totalItems.value = 0;
      currentPage.value = 1;
    } finally {
      isLoading.value = false;
    }
  }

  void updatePageSize(int newSize) {
    pageSize.value = newSize;
    fetchUsers(1, newSize);
  }

  @override
  void onInit() {
    super.onInit();
    fetchUsers(currentPage.value, pageSize.value);
  }
}
