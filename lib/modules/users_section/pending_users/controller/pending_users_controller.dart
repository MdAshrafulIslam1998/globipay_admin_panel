import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/core/data/model/pagination_request.dart';
import 'package:globipay_admin_panel/data/api/app_api.dart';
import 'package:globipay_admin_panel/data/repository/app_repository.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_item_entity.dart';
import 'package:globipay_admin_panel/modules/users_section/pending_users/pending_user.dart';
import 'package:globipay_admin_panel/modules/users_section/pending_users/pending_user_api_service.dart';
import 'package:globipay_admin_panel/modules/users_section/pending_users/pending_user_response.dart';

class PendingUsersController extends BaseController {

  final AppRepository _repository;

  PendingUsersController(this._repository);


  //Rx Variables
  var users = <UserResponseItemEntity>[].obs;
  var totalItems = 0.obs;
  var currentPage = 1.obs;
  var pageSize = 5.obs;
  var isLoading = false.obs;

  PaginationRequest paginationRequest(int page, int limit) => PaginationRequest(
    page: page,
    limit: limit,
  );


  parseUserList(UserResponseEntity response) {
    users.value = response.users ?? [];
    totalItems.value = response.pagination?.total ?? 0;
    currentPage.value = response.pagination?.currentPage ?? 1;
  }
  void updatePageSize(int newSize) {
    pageSize.value = newSize;
    fetchUsers(1, newSize);
  }

  Future<void> fetchUsers(int page, int limit) async {
    final request = paginationRequest(page, limit);
    final repo = _repository.requestForUserList(request, path: AppApi.pendingUserPath);
    callService(repo, onSuccess: (response) {
      parseUserList(response);
    });
  }

  @override
  void onInit() {
    super.onInit();
    fetchUsers(currentPage.value, pageSize.value);
  }
}
