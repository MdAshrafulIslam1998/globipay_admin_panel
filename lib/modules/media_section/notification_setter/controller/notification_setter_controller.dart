// notification_setter_controller.dart
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/modules/media_section/notification_setter/selected_user.dart';

class NotificationSetterController extends GetxController {
  final TextEditingController headingController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final RxString selectedUserType = 'Individual User'.obs;
  final Rx<SelectedUserData?> selectedUser = Rx<SelectedUserData?>(null);

  @override
  void onInit() {
    super.onInit();
    // Load demo selected user
    selectedUser.value = SelectedUserData(
      id: '1',
      name: 'Ram Kumar',
      profileImage: 'https://cdn-icons-png.flaticon.com/512/4113/4113045.png',
      description: 'Lorem ipsum is simply dummy text',
      level: '01',
    );
  }

  @override
  void onClose() {
    headingController.dispose();
    bodyController.dispose();
    super.onClose();
  }

  void updateUserType(String? value) {
    if (value != null) {
      selectedUserType.value = value;
      print('Selected user type: $value');
    }
  }

  void sendNotification() {
    print('Notification Send button clicked!');
    print('Heading: ${headingController.text}');
    print('Body: ${bodyController.text}');
    print('Send to: ${selectedUserType.value}');
    if (selectedUserType.value == 'Individual User') {
      print('Selected User: ${selectedUser.value?.name}');
    }

    // Clear form after sending
    headingController.clear();
    bodyController.clear();

    // Show success message
    Get.snackbar(
      'Success',
      'Notification sent successfully',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
