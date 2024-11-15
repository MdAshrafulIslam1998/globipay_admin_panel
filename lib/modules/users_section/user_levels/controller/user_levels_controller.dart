import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/user_levels/user_level_api_service.dart';
import 'package:globipay_admin_panel/modules/users_section/user_levels/user_levels.dart';

class UserLevelsController extends BaseController {
  var UserLevels = <UserLevel>[].obs;
  var totalItems = 0.obs;
  var currentPage = 1.obs;
  var pageSize = 10.obs;
  var isLoading = false.obs;

  final UserLevelApiService _apiService = UserLevelApiService();

  Future<void> fetchUsersLevel(int page, int limit) async {
    print("🔴::Fetching User levels::🔴");
    print("🔻api/user/verifiedusersweb");
    print("🔻Page: $page, Limit: $limit");

    try {
      isLoading.value = true;
      var userLevelResponse = await _apiService.fetchUsersLevel(page, limit);

      if (userLevelResponse != null) {
        print("🔻Number of users fetched: ${userLevelResponse.users.length}");
        print("🔻Fetched user names:");
        userLevelResponse.users.forEach((UserLevel) => print("- ${UserLevel.name}"));

        UserLevels.assignAll(userLevelResponse.users);
        totalItems.value = userLevelResponse.pagination.total;
        currentPage.value = userLevelResponse.pagination.currentPage;
      } else {
        print("API call returned null response.");
      }
    } catch (e) {
      print("Error fetching users: ${e.toString()}");
      if (e is DioError) {
        print("DioError type: ${e.type}, message: ${e.message}");
      }
    } finally {
      isLoading.value = false;
      print("Loading state is now ${isLoading.value}");
    }
  }

  void updatePageSize(int newSize) {
    print("Updating page size to $newSize and fetching users from page 1");
    pageSize.value = newSize;
    fetchUsersLevel(1, newSize);
  }

  @override
  void onInit() {
    super.onInit();
     fetchUsersLevel(currentPage.value, pageSize.value);
  }
}
