import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/user_levels/user_levels.dart';
import 'package:globipay_admin_panel/modules/users_section/user_levels/user_levels_response.dart';


class UserLevelsController extends BaseController {
  var users = <UserLevel>[].obs;
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
            {
              "user_id": "3c4d5e6f-7890-12gh-ij34-567890cdefg",
              "name": "Tofayel",
              "email": "tofayel.official@gmail.com",
              "amount": 120.00,
              "level_id": 6,
              "level_name": "level 6",
              "status": "Active",
              "date": "2024-09-04T19:56:44.000Z"
            }
          ],
          "pagination": {
            "total": 3,
            "total_pages": 1,
            "current_page": page,
            "limit": limit
          }
        }
      };

      var userResponse = UserLevelResponse.fromJson(mockResponse);
      
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
      print("Error fetching user levels: $e");
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
