import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/modules/media_section/notification_setter/user_model.dart';

class NotificationsController extends BaseController {
  // Notification Creation Form Controllers
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageUrlController = TextEditingController();

  // Observable state variables
  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  final RxList<UserModel> users = <UserModel>[].obs;
  final Rx<NotificationTargetType> selectedTargetType =
      NotificationTargetType.all.obs;
  final RxList<UserModel> selectedUsers = <UserModel>[].obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Populate dummy users
    users.value = [
      UserModel(id: '1', name: 'John Doe', email: 'john@example.com'),
      UserModel(id: '2', name: 'Jane Smith', email: 'jane@example.com'),
      UserModel(id: '3', name: 'Mike Johnson', email: 'mike@example.com'),
      UserModel(id: '4', name: 'Emily Brown', email: 'emily@example.com'),
      UserModel(id: '5', name: 'David Wilson', email: 'david@example.com'),
    ];

    // Populate dummy notifications
    notifications.value = [
      NotificationModel(
        title: 'Welcome Update',
        description: 'Check out our new features!',
        targetType: NotificationTargetType.all,
      ),
      NotificationModel(
        title: 'Special Offer',
        description: 'Exclusive discount for selected users',
        targetType: NotificationTargetType.specific,
        specificUserIds: ['1', '3'],
      ),
    ];
  }

  // Filtered notifications based on search query
  List<NotificationModel> get filteredNotifications {
    if (searchQuery.value.isEmpty) {
      return notifications;
    }
    return notifications.where((notification) =>
    notification.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
        notification.description.toLowerCase().contains(searchQuery.value.toLowerCase())
    ).toList();
  }

  // Search users
  List<UserModel> searchUsers(String query) {
    return users.where((user) =>
    user.name.toLowerCase().contains(query.toLowerCase()) ||
        user.email.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  void createNotification() {
    if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
      Get.snackbar('Error', 'Title and Description are required');
      return;
    }

    final newNotification = NotificationModel(
      title: titleController.text,
      description: descriptionController.text,
      imageUrl: imageUrlController.text.isNotEmpty ? imageUrlController.text : null,
      targetType: selectedTargetType.value,
      specificUserIds: selectedTargetType.value == NotificationTargetType.specific
          ? selectedUsers.map((user) => user.id).toList()
          : null,
    );

    notifications.insert(0, newNotification);

    // Clear controllers and reset state
    titleController.clear();
    descriptionController.clear();
    imageUrlController.clear();
    selectedUsers.clear();
    selectedTargetType.value = NotificationTargetType.all;

    Get.back(); // Close dialog
  }

  void removeNotification(String id) {
    notifications.removeWhere((notification) => notification.id == id);
  }

  void addSelectedUser(UserModel user) {
    if (!selectedUsers.contains(user)) {
      selectedUsers.add(user);
    }
  }

  void removeSelectedUser(UserModel user) {
    selectedUsers.remove(user);
  }

  void setTargetType(NotificationTargetType type) {
    selectedTargetType.value = type;
  }
}