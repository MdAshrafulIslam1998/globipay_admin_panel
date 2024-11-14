import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/active_users_new/user_api_service.dart';
import 'package:globipay_admin_panel/modules/users_section/active_users_new/user_new.dart';

class ActiveUsersNewController extends BaseController {
  var users = <User>[].obs;
  var totalItems = 0.obs;
  var currentPage = 1.obs;
  var pageSize = 10.obs;
  var isLoading = false.obs;

  final UserApiService _apiService = UserApiService();

  Future<void> fetchUsers(int page, int limit) async {
    print("Fetching users with page: $page, limit: $limit");
    try {
      isLoading.value = true;
      var userResponse = await _apiService.fetchUsers(page, limit);

      if (userResponse != null) {
        print(
            "Users fetched successfully. Total users received: ${userResponse.users.length}");
        users.assignAll(userResponse.users);
        totalItems.value = userResponse.pagination.total;
        currentPage.value = userResponse.pagination.currentPage;
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
    fetchUsers(1, newSize);
  }

  @override
  void onInit() {
    super.onInit();
    print(
        "Controller initialized. Fetching users for page ${currentPage.value} with page size ${pageSize.value}");
    fetchUsers(currentPage.value, pageSize.value);
  }
}
