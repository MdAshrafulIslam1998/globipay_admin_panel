import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/modules/active_users_new/user_new.dart';
import 'package:globipay_admin_panel/modules/active_users_new/user_new_response_model.dart';


class ActiveUsersNewController extends BaseController {
  var users = <User>[].obs;
  var totalItems = 0.obs;
  var currentPage = 1.obs;
  var pageSize = 10.obs;
  var isLoading = false.obs;

  Future<void> fetchUsers(int page, int limit) async {
    try {
      isLoading.value = true;

      // Simulated delay to mimic an API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock response data
      var mockResponse = {
        "responseCode": "S100000",
        "responseMessage": "User list fetched successfully",
        "data": {
          "users": [
            {
              "user_id": "1a2b3c4d-5678-90ef-gh12-3456789abcd",
              "name": "Rajesh Mojumder",
              "email": "rajeshmojumder0@gmail.com",
              "amount": 300.00,
              "level_id": 2,
              "level_name": "level 2",
              "status": "Active",
              "date": "2024-09-09T03:04:15.000Z"
            },
            {
              "user_id": "2b3c4d5e-6789-01fg-hi23-4567890bcde",
              "name": "Arzan Hosen",
              "email": "arzanhosen04@gmail.com",
              "amount": 900.00,
              "level_id": 13,
              "level_name": "level 13",
              "status": "Active",
              "date": "2024-09-05T03:50:52.000Z"
            },
          ],
          "pagination": {
            "total": 20,
            "total_pages": 1,
            "current_page": 1,
            "limit": 5
          }
        }
      };

      var userResponse = UserResponse.fromJson(mockResponse);
      if (userResponse != null) {
        users.assignAll(userResponse.users);
        totalItems.value = userResponse.pagination.total;
        currentPage.value = userResponse.pagination.currentPage;
      }
    } catch (e) {
      print("Error fetching users: $e");
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