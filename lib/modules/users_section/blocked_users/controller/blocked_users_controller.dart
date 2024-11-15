import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/blocked_users/blocked_user.dart';
import 'package:globipay_admin_panel/modules/users_section/blocked_users/blocked_user_api_service.dart';
import 'package:globipay_admin_panel/modules/users_section/blocked_users/blocked_user_response.dart';

class BlockedUsersController extends BaseController {
  var users = <BlockedUser>[].obs;
  var totalItems = 0.obs;
  var currentPage = 1.obs;
  var pageSize = 10.obs;
  var isLoading = false.obs;

  final BlockedUserApiService _apiService = BlockedUserApiService();

  Future<void> fetchUsers(int page, int limit) async {
    print("🔴::Fetching Blocked users::🔴");
    print("🔻api/user/blockedusersweb");
    print("🔻Page: $page, Limit: $limit");

    try {
      isLoading.value = true;
      BlockedUserResponse? userResponse =
          await _apiService.fetchBlockedUsers(page, limit);

      if (userResponse != null && userResponse.users.isNotEmpty) {
        users.assignAll(userResponse.users);
        totalItems.value = userResponse.pagination.total;
        currentPage.value = userResponse.pagination.currentPage;
        print("✅ Users fetched successfully.");

        // Log user count and names
        print("🔻Number of users fetched: ${userResponse.users.length}");
        print("🔻Fetched user names:");
        userResponse.users.forEach((user) => print("- ${user.name}"));
      } else {
        users.clear();
        totalItems.value = 0;
        currentPage.value = 1;
        print("🔻No users found in response.");
      }
    } catch (e) {
      print("🔻Error fetching blocked users: $e");
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
