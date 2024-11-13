import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/user_amount/user_amount.dart';
import 'package:globipay_admin_panel/modules/users_section/user_amount/user_amount_response.dart';


class UserAmountController extends BaseController {
  var users = <UserAmount>[].obs;
  var totalItems = 0.obs;
  var currentPage = 1.obs;
  var pageSize = 10.obs;
  var isLoading = false.obs;

  Future<void> fetchUserAmounts(int page, int limit) async {
    try {
      isLoading.value = true;

      // Mock response data
      var mockResponse = {
        "responseCode": "S100000",
        "responseMessage": "Transaction history fetched successfully",
        "data": {
          "users": [
            {
              "user_id": "b7746c19-7a61-11ef-8211-80fa5b888c9a",
              "name": "John Doe",
              "email": "jhn@example.com",
              "status": "Active",
              "amount": {
                "z": {"PRIMARY": 85, "SECONDARY": 55},
                "V": {"PRIMARY": 0, "SECONDARY": 205},
                "&": {"PRIMARY": 0, "SECONDARY": 55}
              }
            },
            {
              "user_id": "b7746c19-7a61-11ef-8211-80fa5b888c9a",
              "name": "John Doe2",
              "email": "jhn@example.com",
              "status": "Active",
              "amount": {
                "z": {"PRIMARY": 85, "SECONDARY": 55},
                "V": {"PRIMARY": 0, "SECONDARY": 205},
                "&": {"PRIMARY": 0, "SECONDARY": 55}
              }
            },
          ],
          "pagination": {
            "total": 27,
            "total_pages": 6,
            "current_page": page,
            "limit": limit
          }
        }
      };

      var userAmountResponse = UserAmountResponse.fromJson(mockResponse);

      users.assignAll(userAmountResponse.users);
      totalItems.value = userAmountResponse.pagination.total;
      currentPage.value = userAmountResponse.pagination.currentPage;

    } catch (e) {
      print("Error fetching user amounts: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void updatePageSize(int newSize) {
    pageSize.value = newSize;
    fetchUserAmounts(1, newSize);
  }

  @override
  void onInit() {
    super.onInit();
    fetchUserAmounts(currentPage.value, pageSize.value);
  }
}
