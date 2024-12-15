import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/core/constants/enum/table_name.dart';
import 'package:globipay_admin_panel/core/constants/table_header_visibility.dart';
import 'package:globipay_admin_panel/core/data/local/repository/token_repository.dart';
import 'package:globipay_admin_panel/core/data/model/pagination_request.dart';
import 'package:globipay_admin_panel/core/utils/custom_dialog.dart';
import 'package:globipay_admin_panel/data/repository/app_repository.dart';
import 'package:globipay_admin_panel/entity/response/misc/misc_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/misc/misc_response_item_entity.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:globipay_admin_panel/router/route_path.dart';
/**
 * Created by Abdullah on 14/12/24.
 */

class MiscellaneousController extends BaseController{

  final AppRepository _repository;
  final TokenRepository tokenRepository;
  String currentRole = '';

  MiscellaneousController(this._repository, this.tokenRepository);

  //Rx Variables
  var miscs = <MiscResponseItemEntity>[].obs;
  var totalItems = 0.obs;
  var currentPage = 1.obs;
  var pageSize = 10.obs;
  var isLoading = false.obs;
  RxList<String> visibleColumns = RxList<String>();

  PaginationRequest paginationRequest(int page, int limit) => PaginationRequest(
    page: page,
    limit: limit,
  );

  parseMiscList(MiscResponseEntity response) {
    miscs.value = response.services ?? [];
    totalItems.value = response.pagination?.total ?? 0;
    currentPage.value = response.pagination?.currentPage ?? 1;
  }

  Future<void> fetchMiscs(int page, int limit) async {
    final request = paginationRequest(page, limit);
    final repo = _repository.requestForMisc(request);
    callService(repo, onSuccess: (response) {
      parseMiscList(response);
    });
  }

  void updatePageSize(int newSize) {
    print("Updating page size to $newSize and fetching users from page 1");
    pageSize.value = newSize;
    fetchMiscs(1, newSize);
  }

  Future<String> getRole() async {
    return await tokenRepository.getRole().toString();
  }

  @override
  void onInit() {
    fetchMiscs(currentPage.value, pageSize.value);
    getVisibleColumns();
    super.onInit();
  }

  getVisibleColumns() async {
    visibleColumns.value = await TableHeaderVisibility.getTableVisibleColumn(
        tableName: TableName.MISC_TABLE);
  }

  void addNewMisc() {
    AppRoutes.pushNamed(RoutePath.addMisc).then((value) {
      fetchMiscs(currentPage.value, pageSize.value);
    });
  }

  void removeMisc(int? service_id) {
    askForConfirmation(
      onPositiveAction: () {
        final repo = _repository.requestToRemoveMisc(service_id.toString());
        callService(repo, onSuccess: (response) {
          fetchMiscs(currentPage.value, pageSize.value);
        });
      },
    );

  }
}