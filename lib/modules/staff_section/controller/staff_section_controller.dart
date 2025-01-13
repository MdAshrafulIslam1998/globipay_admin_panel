// staff_section_controller.dart
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/core/constants/enum/role_name.dart';
import 'package:globipay_admin_panel/core/data/model/common_data_entity.dart';
import 'package:globipay_admin_panel/core/data/model/pagination_request.dart';
import 'package:globipay_admin_panel/data/repository/app_repository.dart';
import 'package:globipay_admin_panel/entity/request/staff/add_staff_request_entity.dart';
import 'package:globipay_admin_panel/entity/response/staff/staff_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/staff/staff_response_item_entity.dart';
import 'package:uuid/uuid.dart';

class StaffSectionController extends BaseController {
  final GlobalKey<FormState> staffFormKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AppRepository appRepository;

  StaffSectionController(this.appRepository);


  //Rx Variables
  Rxn<CommonDataEntity> selectedRole = Rxn<CommonDataEntity>(null);
  final RxBool isPasswordVisible = false.obs;
  final RxBool isFormValid = false.obs;
  final RxList<CommonDataEntity> roles = <CommonDataEntity>[].obs;

  var staffList = <StaffResponseItemEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    requestForStaffList();
    requestForRoles();
  }

  void requestForRoles(){
    var temp = <CommonDataEntity>[];
    temp.add(
        CommonDataEntity(
            key: RoleName.ADMIN.title,
          value: RoleName.ADMIN.code,
        )
    );

    temp.add(
        CommonDataEntity(
            key: RoleName.SUB_ADMIN.title,
          value: RoleName.SUB_ADMIN.code,
        )
    );

    temp.add(
        CommonDataEntity(
            key: RoleName.MODERATOR.title,
          value: RoleName.MODERATOR.code,
        )
    );
    roles.value = temp;
  }

  void deleteRole(StaffResponseItemEntity staff) {
    askForConfirmation(
        message: 'Are you sure you want to remove this staff?',
        onPositiveAction: () {
      removeStaff(staff);
    });
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }


  void createRole() {
    if (staffFormKey.currentState!.validate()) {
      requestToAddStaff();
    }
  }

  PaginationRequest paginationRequest = PaginationRequest(page: 1, limit: 100);

  void parseStaffList(StaffResponseEntity data) {
    staffList.value = data.staffs ?? [];
  }

  clearAllFields(){
    Future.delayed(const Duration(milliseconds: 150), () {
      staffFormKey.currentState?.reset();
    });
  }
  AddStaffRequestEntity generateAddStaffRequest() {
    return AddStaffRequestEntity(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      role: selectedRole.value?.value,
      status: "ACTIVE"
    );
  }
  //Network Calls
  void requestForStaffList() {
    final repo = appRepository.requestForStaffList(paginationRequest);
    callService(repo, onSuccess: (data) {
      parseStaffList(data);
    });
  }

  void requestToAddStaff(){
    final repo = appRepository.requestToAddStaff(generateAddStaffRequest());
    callService(repo, onSuccess: (data) {
      showSnackBar(message: 'Staff added successfully',status: SnackBarStatus.SUCCESS);
      requestForStaffList();
      clearAllFields();
    });
  }

  void removeStaff(StaffResponseItemEntity staff) {
    final repo = appRepository.requestToRemoveStaff(
        staff.staffId.toString() ?? "");
    callService(repo, onSuccess: (data) {
      showSnackBar(message: 'Staff removed successfully',
          status: SnackBarStatus.SUCCESS);
      requestForStaffList();
    });
  }

    @override
    void onClose() {
      nameController.dispose();
      emailController.dispose();
      passwordController.dispose();
      super.onClose();
    }


}
