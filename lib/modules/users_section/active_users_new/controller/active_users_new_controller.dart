import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/core/constants/enum/table_name.dart';
import 'package:globipay_admin_panel/core/constants/enum/user_status.dart';
import 'package:globipay_admin_panel/core/constants/table_header_visibility.dart';
import 'package:globipay_admin_panel/core/data/local/repository/token_repository.dart';
import 'package:globipay_admin_panel/core/data/model/pagination_request.dart';
import 'package:globipay_admin_panel/core/di/injector.dart';
import 'package:globipay_admin_panel/core/widgets/app_print.dart';
import 'package:globipay_admin_panel/data/repository/app_repository.dart';
import 'package:globipay_admin_panel/data/services/supabase_service.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_item_entity.dart';
import 'package:globipay_admin_panel/modules/chat/controller/chat_shared_controller.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:globipay_admin_panel/router/route_path.dart';

class ActiveUsersNewController extends BaseController {
  final AppRepository _repository;
  @override
  final TokenRepository tokenRepository;
  String currentRole = '';
  final ChatSharedController sharedController =
  Injector.resolve<ChatSharedController>();
  ActiveUsersNewController(this._repository, this.tokenRepository);

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
    final repo = _repository.requestForUserList(request);
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
      tableName: TableName.USER_ACTIVE_TABLE);
  }

  void onUserDetailsClicked(UserResponseItemEntity user) {
    AppRoutes.pushNamed(RoutePath.pendingProfile,extra: user);
  }

  void onUserDeleteClicked(UserResponseItemEntity user) {
    askForConfirmation(
      message: 'Are you sure you want to delete this user?',
      onPositiveAction: (){
        requestToDeleteUser(user);
      },
    );
  }

  void onUserMessageClicked(UserResponseItemEntity user) async{
    final userId = await tokenRepository.getStuffId();

    appPrint("User ID: $userId");

    final response = await SupabaseService().client.rpc('start_chat_session', params: {
      '_customer_id': user.userId,
      '_category': "-1",
    }).execute();

    if (response.data != null) {
      final userID = await tokenRepository.getStuffId();
      sharedController.setCurrentUserId(userID);
      String sessionId = response.data;

      sharedController.setChatSessionId(sessionId);
      sharedController.setCustomerID(user.userId);

      AppRoutes.pushNamed(RoutePath.chat);

    }


  }

  void requestToDeleteUser(UserResponseItemEntity user) async {
    final repo = _repository.requestToUpdateUserStatus(
        user.userId ?? '',
        UserStatus.DELETED,
    );

    callService(repo, onSuccess: (response) {
      fetchUsers(currentPage.value, pageSize.value);
    });
  }
}
