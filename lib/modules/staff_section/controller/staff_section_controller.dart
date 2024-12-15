// staff_section_controller.dart
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';

class StaffSectionController extends BaseController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxList<Map<String, dynamic>> roles = <Map<String, dynamic>>[].obs;
  final RxString selectedRole = ''.obs;
  final RxList<Map<String, dynamic>> staffList = <Map<String, dynamic>>[].obs;
  final RxBool isLoadingRoles = false.obs;
  final RxBool isLoadingStaff = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRoles();
    fetchStaffList();
  }

  void fetchRoles() async {
    isLoadingRoles.value = true;
    // Simulated API response for roles
    await Future.delayed(const Duration(seconds: 1));
    roles.value = [
      {"id": 1, "role_name": "Admin"},
      {"id": 3, "role_name": "Subadmin"},
      {"id": 4, "role_name": "Moderator"},
    ];
    isLoadingRoles.value = false;
  }

  void fetchStaffList() async {
    isLoadingStaff.value = true;
    // Simulated API response for staff list
    await Future.delayed(const Duration(seconds: 1));
    staffList.value = [
      {"staff_id": 3, "name": "Mike Johnson", "email": "mike.johnson@example.com", "status": "INACTIVE", "role_name": "Subadmin"},
      {"staff_id": 4, "name": "Sara Lee", "email": "sara.lee@example.com", "status": "ACTIVE", "role_name": "Moderator"},
    ];
    isLoadingStaff.value = false;
  }

  void addStaff() {
    if (nameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty || selectedRole.value.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please fill all fields',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Simulated staff addition
    staffList.add({
      "staff_id": staffList.length + 1,
      "name": nameController.text,
      "email": emailController.text,
      "status": "ACTIVE",
      "role_name": roles.firstWhere((role) => role['id'].toString() == selectedRole.value)['role_name'],
    });

    Get.snackbar(
      'Staff Added',
      'Staff has been added successfully',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    clearFields();
  }

  void clearFields() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    selectedRole.value = '';
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
