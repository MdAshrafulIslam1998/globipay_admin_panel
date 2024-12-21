import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/core/constants/enum/table_name.dart';
import 'package:globipay_admin_panel/core/constants/enum/user_status.dart';
import 'package:globipay_admin_panel/core/constants/table_header_visibility.dart';
import 'package:globipay_admin_panel/core/data/local/repository/token_repository.dart';
import 'package:globipay_admin_panel/core/data/model/pagination_request.dart';
import 'package:globipay_admin_panel/data/repository/app_repository.dart';
import 'package:globipay_admin_panel/entity/response/trans_history_response.dart/all_transactions_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/trans_history_response.dart/transaction_item_entity.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_item_entity.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:globipay_admin_panel/router/route_path.dart';

class UserAmountController extends BaseController {
  final AppRepository _repository;
  final TokenRepository tokenRepository;
  String currentRole = '';

  UserAmountController(this._repository, this.tokenRepository);

  //Rx Variables
  var transactions = <TransactionItemEntity>[].obs;
  var totalItems = 0.obs;
  var currentPage = 1.obs;
  var pageSize = 10.obs;
  var isLoading = false.obs;
  RxList<String> visibleColumns = RxList<String>();

  PaginationRequest paginationRequest(int page, int limit) => PaginationRequest(
        page: page,
        limit: limit,
      );

  parseTransactionList(AllTransactionsResponseEntity response) {
    transactions.value = response.transactions ?? [];
    totalItems.value = response.pagination?.total ?? 0;
    currentPage.value = response.pagination?.currentPage ?? 1;
  }

  Future<void> fetchUserAmountDetails(int page, int limit) async {
    final request = paginationRequest(page, limit);
    final repo =
        _repository.requestForUserAmountDetails(paginationRequest: request);
    callService(repo, onSuccess: (response) {
      parseTransactionList(response);
    });
  }

  void updatePageSize(int newSize) {
    print("Updating page size to $newSize and fetching users from page 1");
    pageSize.value = newSize;
    fetchUserAmountDetails(1, newSize);
  }

  Future<String> getRole() async {
    return await tokenRepository.getRole().toString();
  }

  @override
  void onInit() {
    fetchUserAmountDetails(currentPage.value, pageSize.value);
    getVisibleColumns();
    super.onInit();
  }

  getVisibleColumns() async {
    visibleColumns.value = await TableHeaderVisibility.getTableVisibleColumn(
        tableName: TableName.USER_AMOUNT_TABLE);
  }

  void onEditCoinClicked(TransactionItemEntity transaction) {
    AppRoutes.pushNamed(RoutePath.pendingProfile, extra: transaction);
  }

  void onUserDetailsClicked(TransactionItemEntity transaction){
    AppRoutes.pushNamed(RoutePath.pendingProfile, extra: transaction);
  }
}
