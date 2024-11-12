import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/modules/pending_users/pending_user.dart';
import 'package:globipay_admin_panel/modules/pending_users/pending_user_response.dart';

class PendingUsersController extends BaseController {
  var users = <PendingUser>[].obs;
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
              "user_id": "5f6a7b8c-1234-56de-7890-abcdef123456",
              "name": "Jamell Katebin",
              "email": "tofayel.officialsdfsl1@gmail.com",
              "amount": 250.00,
              "level_id": 4,
              "level_name": "level 4",
              "status": "Pending",
              "date": "2024-09-04T19:56:44.000Z"
            },
            {
              "user_id": "6b7c8d9e-2345-67ef-8901-bcdef2345678",
              "name": "Mahin Rahman",
              "email": "mahin.rahman@example.com",
              "amount": 500.00,
              "level_id": 7,
              "level_name": "level 7",
              "status": "Pending",
              "date": "2024-09-05T14:20:30.000Z"
            }
          ],
          "pagination": {
            "total": 2,
            "total_pages": 1,
            "current_page": page,
            "limit": limit
          }
        }
      };

      var userResponse = PendingUserResponse.fromJson(mockResponse);
      
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
      print("Error fetching pending users: $e");
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