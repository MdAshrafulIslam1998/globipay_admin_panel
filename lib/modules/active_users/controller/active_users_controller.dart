import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/modules/active_users/user.dart';
import 'package:globipay_admin_panel/modules/active_users/user_response.dart';
class ActiveUsersController extends BaseController {
  var users = <User>[].obs;              // Observable list of users to display in the grid
  var totalItems = 0.obs;                 // Total number of items from the API
  var currentPage = 1.obs;                // Current page index
  var pageSize = 10.obs;                  // Page size (can be 10, 20, 30, etc.)
  var isLoading = false.obs;              // Loading indicator

  // Fetch users from API based on page and page size
  Future<void> fetchUsers(int page, int limit) async {
    try {
      isLoading.value = true;

      // Simulated delay to mimic an API call
     // await Future.delayed(Duration(seconds: 1));

      // Mock response data
      var mockResponse = {
        "responseCode": "S100000",
        "responseMessage": "Users fetched successfully",
        "data": {
          "users": List.generate(
            limit,
                (index) => {
              "id": (page - 1) * limit + index + 1,
              "name": "User ${(page - 1) * limit + index + 1}",
              "designation": "Designation ${(page - 1) * limit + index + 1}",
              "age": 20 + ((page - 1) * limit + index) % 10
            },
          ),
          "pagination": {
            "total": 100, // Total number of items (for example purposes)
            "total_pages": 10,
            "current_page": page,
            "limit": limit
          }
        }
      };

      // Parse mock response
      var userResponse = UserResponse.fromJson(mockResponse);
      if (userResponse != null) {
        users.assignAll(userResponse.users);             // Update the users list
        totalItems.value = userResponse.pagination.total; // Update total items for pagination
        currentPage.value = userResponse.pagination.currentPage;
      }
    } catch (e) {
      print("Error fetching users: $e");                  // Error handling
    } finally {
      isLoading.value = false;
    }
  }


  // Update page size and reset to first page
  void updatePageSize(int newSize) {
    pageSize.value = newSize;
    fetchUsers(1, newSize);                          // Reload data with new page size
  }

  @override
  void onInit() {
    super.onInit();
    fetchUsers(currentPage.value, pageSize.value);   // Initial data fetch
  }
}


