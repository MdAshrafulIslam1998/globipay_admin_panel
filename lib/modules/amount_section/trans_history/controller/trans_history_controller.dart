import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/core/constants/enum/table_name.dart';
import 'package:globipay_admin_panel/core/constants/table_header_visibility.dart';
import 'package:globipay_admin_panel/core/data/local/repository/token_repository.dart';
import 'package:globipay_admin_panel/core/data/model/pagination_request.dart';
import 'package:globipay_admin_panel/data/api/app_api.dart';
import 'package:globipay_admin_panel/data/repository/app_repository.dart';
import 'package:globipay_admin_panel/entity/response/category/category_item_entity.dart';
import 'package:globipay_admin_panel/entity/response/trans_history_response.dart/all_transactions_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/trans_history_response.dart/transaction_item_entity.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_item_entity.dart';
import 'package:globipay_admin_panel/core/constants/enum/sort_type.dart';

class TransHistoryController extends BaseController {
  final AppRepository _repository;
  @override
  final TokenRepository tokenRepository;
  String currentRole = '';

  RxBool isCategorySelectionVisible = false.obs;

  RxList<CategoryItemEntity> categoriesList = <CategoryItemEntity>[].obs;

  Rxn<CategoryItemEntity> selectedCategory = Rxn<CategoryItemEntity>(null);

  TransHistoryController(this._repository, this.tokenRepository);

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

  Future<void> fetchTransactionHistory(int page, int limit) async {
    final request = paginationRequest(page, limit);
    final repo = _repository.requestForAllTransactions(paginationRequest: request);
    callService(repo, onSuccess: (response) {
      parseTransactionList(response);
    });
  }

   Future<void> fetchUserWiseTransactionHistory(int page, int limit) async {

    transactions.clear();
    final request = paginationRequest(page, limit);
    final repo = _repository.requestForAllTransactions(paginationRequest: request, path: AppApi.USER_WISE_TRANSACTIONS);
    callService(repo, onSuccess: (response) {
      parseTransactionList(response);
    });

  }


  void setCategorySelectionVisibility(bool? value) {
    isCategorySelectionVisible.value = value ?? false;
  }

  PaginationRequest categoryWisePagination(CategoryItemEntity? item, int page, int limit) {
    return PaginationRequest(
        page: currentPage.value,
        limit: pageSize.value,
        category: item?.id ?? 0
    );
  }

  void setSelectedCategory(CategoryItemEntity? categoryItemEntity) {
    selectedCategory.value = categoryItemEntity;
    if(categoryItemEntity != null){
      fetchCategoryWiseTransactionHistory(currentPage.value, pageSize.value);
    }
  }

  Future<void> fetchCategoryWiseTransactionHistory(int page, int limit) async {
    transactions.clear();
    final request = categoryWisePagination(selectedCategory.value,page, limit);
    final repo = _repository.requestForAllTransactions(paginationRequest: request, path: AppApi.CAT_WISE_TRANSACTIONS);
    callService(repo, onSuccess: (response) {
      parseTransactionList(response);
    });

  }




  void updatePageSize(int newSize) {
    print("Updating page size to $newSize and fetching users from page 1");
    pageSize.value = newSize;
    fetchTransactionHistory(1, newSize);
  }

  Future<String> getRole() async {
    return tokenRepository.getRole().toString();
  }

  
  @override
  void onInit() {
    requestForCategories();
    fetchTransactionHistory(currentPage.value, pageSize.value);
    getVisibleColumns();
    super.onInit();
  }

  getVisibleColumns() async {
    visibleColumns.value = await TableHeaderVisibility.getTableVisibleColumn(
        tableName: TableName.USER_TRANSACTION_TABLE);
  }

  void requestForCategories(){
    categoriesList.clear();
    final repo = _repository.requestForCategories(paginationRequest(1, 100));
    callService(repo, onSuccess: (response) {
      categoriesList.value = response.categories ?? [];
    });
  }
}
