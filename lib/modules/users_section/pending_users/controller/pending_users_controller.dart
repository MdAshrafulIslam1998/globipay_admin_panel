import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/pending_users/pending_user.dart';
import 'package:globipay_admin_panel/modules/users_section/pending_users/pending_user_api_service.dart';
import 'package:globipay_admin_panel/modules/users_section/pending_users/pending_user_response.dart';

class PendingUsersController extends BaseController {
  var users = <PendingUser>[].obs;
  var totalItems = 0.obs;
  var currentPage = 1.obs;
  var pageSize = 10.obs;
  var isLoading = false.obs;

  final PendingUserApiService _apiService = PendingUserApiService();

  Future<void> fetchUsers(int page, int limit) async {

    print("🔴::Fetching Pending users::🔴");
    print("🔻api/user/pendingusersweb");
    print("🔻Page: $page, Limit: $limit");

    try {
      isLoading.value = true;
      PendingUserResponse? userResponse =
          await _apiService.fetchPendingUsers(page, limit);

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
      print("🔻Error fetching pending users: $e");
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
