import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/core/data/model/pagination_request.dart';
import 'package:globipay_admin_panel/data/api/app_api.dart';
import 'package:globipay_admin_panel/data/repository/app_repository.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_item_entity.dart';
import 'package:globipay_admin_panel/modules/users_section/blocked_users/blocked_user.dart';
import 'package:globipay_admin_panel/modules/users_section/blocked_users/blocked_user_api_service.dart';
import 'package:globipay_admin_panel/modules/users_section/blocked_users/blocked_user_response.dart';

class BlockedUsersController extends BaseController {
  var users = <UserResponseItemEntity>[].obs;
  var totalItems = 0.obs;
  var currentPage = 1.obs;
  var pageSize = 5.obs;
  var isLoading = false.obs;

  final AppRepository _repository;

  BlockedUsersController(this._repository);

  PaginationRequest paginationRequest(int page, int limit) => PaginationRequest(
    page: page,
    limit: limit,
  );


  parseUserList(UserResponseEntity response) {
    users.value = response.users ?? [];
    totalItems.value = response.pagination?.total ?? 0;
    currentPage.value = response.pagination?.currentPage ?? 1;
  }

  Future<void> fetchUsers(int page, int limit) async {
    final request = paginationRequest(page, limit);
    final repo = _repository.requestForUserList(request, path: AppApi.blockedUserPath);
    callService(repo, onSuccess: (response) {
      parseUserList(response);
    });
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
