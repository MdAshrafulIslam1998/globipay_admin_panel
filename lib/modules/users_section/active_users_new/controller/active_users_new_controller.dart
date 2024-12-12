import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/core/data/local/repository/token_repository.dart';
import 'package:globipay_admin_panel/core/data/model/pagination_request.dart';
import 'package:globipay_admin_panel/data/repository/app_repository.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_item_entity.dart';
import 'package:globipay_admin_panel/modules/role_manager.dart';


class ActiveUsersNewController extends BaseController {

  final AppRepository _repository;
  final TokenRepository tokenRepository;
  String currentRole = '';


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

  Future<String> getRole()async{
    return await tokenRepository.getRole().toString();

  }

  @override
  void onInit(){
   tokenRepository.getRole().then((role){
     visibleColumns.value = RoleManager.getVisibleColumns('4');
     fetchUsers(currentPage.value, pageSize.value);
   });

    super.onInit();
  }
}


