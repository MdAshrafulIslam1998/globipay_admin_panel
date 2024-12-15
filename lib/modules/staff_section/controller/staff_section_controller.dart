import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/core/data/model/pagination_request.dart';
import 'package:globipay_admin_panel/core/utils/custom_dialog.dart';
import 'package:globipay_admin_panel/data/repository/app_repository.dart';
import 'package:globipay_admin_panel/entity/response/fetch_staff/all_staff_item_entity.dart';
import 'package:globipay_admin_panel/entity/response/fetch_staff/all_staff_response_entity.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:globipay_admin_panel/router/route_path.dart';

class StaffSectionController extends BaseController {
  final AppRepository _appRepository;

  final RxList<AllStaffItemEntity> staffList = <AllStaffItemEntity>[].obs;
  final RxString searchQuery = ''.obs;

  StaffSectionController(this._appRepository);

  @override
  void onInit() {
    super.onInit();
    fetchStaff();
  }

  void fetchStaff() {
    final request = PaginationRequest(page: 1, limit: 100);
    final apiCall = _appRepository.requestForAllStaffs(request);

    callService(
      apiCall,
      onSuccess: (response) {
        parseStaffList(response);
      },
    );
  }

  void parseStaffList(AllStaffResponseEntity response) {
    staffList.clear();
    staffList.value = response.templates;
  }

  List<AllStaffItemEntity> get filteredStaffList {
    if (searchQuery.value.isEmpty) {
      return staffList;
    }
    return staffList.where((staff) {
      final name = staff.name?.toLowerCase() ?? '';
      final email = staff.email?.toLowerCase() ?? '';
      return name.contains(searchQuery.value.toLowerCase()) ||
          email.contains(searchQuery.value.toLowerCase());
    }).toList();
  }

  void removeStaff(int staffId) {
    showCustomDialog(
      "Are you sure you want to remove this staff?",
      positiveButtonAction: () {
        _removeStaffApi(staffId);
      },
      positiveButtonText: "Yes",
      negativeButtonText: "No",
      negativeButtonAction: () {
        AppRoutes.pop();
      },
    );
  }

  void _removeStaffApi(int staffId) {
    //final apiCall = _appRepository.requestToRemoveStaff(staffId.toString());

    print("staffId $staffId");

    // callService(
    //   //apiCall,
    //   onSuccess: (response) {
    //     fetchStaff();
    //     showCustomDialog(
    //       "Staff Removed Successfully",
    //       positiveButtonAction: () {
    //         AppRoutes.pop();
    //       },
    //       positiveButtonText: "OK",
    //     );
    //   },
    // );
  }
}
