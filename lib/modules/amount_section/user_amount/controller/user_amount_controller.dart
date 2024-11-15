import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/modules/amount_section/user_amount/user_amount.dart';
import 'package:globipay_admin_panel/modules/amount_section/user_amount/user_amount_api_service.dart';

class UserAmountController extends BaseController {
  var users = <UserAmount>[].obs;
  var totalItems = 0.obs;
  var currentPage = 1.obs;
  var pageSize = 10.obs;
  var isLoading = false.obs;

  final UserAmountApiService _apiService = UserAmountApiService();

  Future<void> fetchUserAmounts(int page, int limit) async {
    try {
      isLoading.value = true;

      print("🔴 Fetching User Amount Details 🔴");
      print("🔻 Endpoint: api/amountdetailsweb");
      print("🔻 Page: $page, Limit: $limit");

      var userAmountResponse = await _apiService.fetchUserAmounts(page, limit);

      if (userAmountResponse != null) {
        print("✅ User amounts fetched successfully.");
        users.assignAll(userAmountResponse.users);
        totalItems.value = userAmountResponse.pagination.total;
        currentPage.value = userAmountResponse.pagination.currentPage;

        print("🔻 Number of users fetched: ${userAmountResponse.users.length}");
        print("🔻 Fetched user names:");
        userAmountResponse.users.forEach((user) => print("- ${user.name}"));
      } else {
        print("⚠️ API call returned null response.");
      }
    } catch (e) {
      print("Error fetching user amounts: ${e.toString()}");
    } finally {
      isLoading.value = false;
      print("Loading state is now ${isLoading.value}");
    }
  }

  void updatePageSize(int newSize) {
    print("Updating page size to $newSize and fetching user amounts from page 1");
    pageSize.value = newSize;
    fetchUserAmounts(1, newSize);
  }

  @override
  void onInit() {
    super.onInit();
    fetchUserAmounts(currentPage.value, pageSize.value);
  }
}
