import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/core/constants/enum/table_name.dart';
import 'package:globipay_admin_panel/core/constants/table_header_visibility.dart';
import 'package:globipay_admin_panel/core/data/local/repository/token_repository.dart';
import 'package:globipay_admin_panel/core/data/model/pagination_request.dart';
import 'package:globipay_admin_panel/data/api/app_api.dart';
import 'package:globipay_admin_panel/data/repository/app_repository.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_item_entity.dart';

class PendingUsersController extends BaseController {
  final AppRepository _repository;
  @override
  final TokenRepository tokenRepository;
  String currentRole = '';

  PendingUsersController(this._repository, this.tokenRepository);

  //Rx Variables
  var users = <UserResponseItemEntity>[].obs;
  var totalItems = 0.obs;
  var currentPage = 1.obs;
  var pageSize = 10.obs;
  var isLoading = false.obs;
  RxList<String> visibleColumns = RxList<String>();

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
    final repo = _repository.requestForUserList(request, path: AppApi.pendingUserPath);
    callService(repo, onSuccess: (response) {
      parseUserList(response);
    });
  }

  void updatePageSize(int newSize) {
    print("Updating page size to $newSize and fetching users from page 1");
    pageSize.value = newSize;
    fetchUsers(1, newSize);
  }

  Future<String> getRole() async {
    return tokenRepository.getRole().toString();
  }

  @override
  void onInit() {
    fetchUsers(currentPage.value, pageSize.value);
    getVisibleColumns();
    super.onInit();
  }

  getVisibleColumns() async {
    visibleColumns.value = await TableHeaderVisibility.getTableVisibleColumn(
      tableName: TableName.USER_PENDING_TABLE);
  }
}
