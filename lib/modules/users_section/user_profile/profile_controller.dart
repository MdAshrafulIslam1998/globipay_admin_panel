/**
 * Created by Abdullah on 15/12/24.
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/user_profile/activity_log_model.dart';
import 'package:globipay_admin_panel/modules/users_section/user_profile/transaction_model.dart';
import 'package:globipay_admin_panel/modules/users_section/user_profile/notification_model.dart';
import 'package:intl/intl.dart';

class ProfileController extends BaseController {
  // Existing profile data
  Rx<ProfileData?> profileData = Rx<ProfileData?>(null);

  // Transactions
  RxList<TransactionModel> transactions = RxList<TransactionModel>();
  RxString transactionSearchQuery = RxString('');
  ScrollController transactionScrollController = ScrollController();
  RxBool isTransactionLoading = RxBool(false);

  // Activity Logs
  RxList<ActivityLogModel> activityLogs = RxList<ActivityLogModel>();
  RxString activitySearchQuery = RxString('');
  ScrollController activityScrollController = ScrollController();
  RxBool isActivityLoading = RxBool(false);

  // Notifications
  RxList<NotificationModel> notifications = RxList<NotificationModel>();
  RxString notificationSearchQuery = RxString('');
  ScrollController notificationScrollController = ScrollController();
  RxBool isNotificationLoading = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    fetchInitialData();
    setupScrollListeners();
  }

  void fetchInitialData() {
    // Simulate loading profile data
    profileData.value = ProfileData(
        fullName: 'John Doe',
        email: 'john.doe@example.com',
        dob: DateFormat('dd/MM/yyyy').format(DateTime(2024, 1, 1)),
        gender: "Male",
        phone: "01700000000",
        address: "127.0.0.1",
        selfiePath:
            "https://www.shutterstock.com/image-vector/man-character-face-avatar-glasses-600nw-542759665.jpg",
        frontIdPath:
            "https://cdn.pixabay.com/photo/2022/11/09/00/44/aadhaar-card-7579588_640.png",
        backIdPath:
            "https://5.imimg.com/data5/UF/GX/GLADMIN-63025529/adhar-card-service-500x500.png"

        // ... other profile details
        );

    // Generate dummy transactions
    transactions.value = List.generate(
        20,
        (index) => TransactionModel(
              id: 'TX$index',
              dateTime: DateTime.now().subtract(Duration(days: index)),
              type: index % 2 == 0 ? 'Primary' : 'Secondary',
              categoryName: index % 2 == 0 ? 'Salary' : 'Expenses',
              amount: (index + 1) * 100.0,
            ));

    // Generate dummy activity logs
    activityLogs.value = List.generate(
        20,
        (index) => ActivityLogModel(
              id: 'AL$index',
              timestamp: DateTime.now().subtract(Duration(hours: index)),
              type: _getRandomActivityType(index),
            ));

    // Generate dummy notifications
    notifications.value = List.generate(
        20,
        (index) => NotificationModel(
              id: 'NT$index',
              content: _getRandomNotificationContent(index),
              timestamp: DateTime.now().subtract(Duration(days: index ~/ 2)),
            ));
  }

  void setupScrollListeners() {
    transactionScrollController.addListener(_loadMoreTransactions);
    activityScrollController.addListener(_loadMoreActivityLogs);
    notificationScrollController.addListener(_loadMoreNotifications);
  }

  void _loadMoreTransactions() {
    if (transactionScrollController.position.pixels ==
        transactionScrollController.position.maxScrollExtent) {
      _fetchMoreTransactions();
    }
  }

  void _loadMoreActivityLogs() {
    if (activityScrollController.position.pixels ==
        activityScrollController.position.maxScrollExtent) {
      _fetchMoreActivityLogs();
    }
  }

  void _loadMoreNotifications() {
    if (notificationScrollController.position.pixels ==
        notificationScrollController.position.maxScrollExtent) {
      _fetchMoreNotifications();
    }
  }

  void _fetchMoreTransactions() async {
    if (isTransactionLoading.value) return;

    isTransactionLoading.value = true;
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    // Add more dummy transactions
    transactions.addAll(List.generate(
        10,
        (index) => TransactionModel(
              id: 'TX${transactions.length + index}',
              dateTime: DateTime.now()
                  .subtract(Duration(days: transactions.length + index)),
              type: index % 2 == 0 ? 'Primary' : 'Secondary',
              categoryName: index % 2 == 0 ? 'Bonus' : 'Investment',
              amount: (transactions.length + index + 1) * 50.0,
            )));

    isTransactionLoading.value = false;
  }

  void _fetchMoreActivityLogs() async {
    if (isActivityLoading.value) return;

    isActivityLoading.value = true;
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    // Add more dummy activity logs
    activityLogs.addAll(List.generate(
        10,
        (index) => ActivityLogModel(
              id: 'AL${activityLogs.length + index}',
              timestamp: DateTime.now()
                  .subtract(Duration(hours: activityLogs.length + index)),
              type: _getRandomActivityType(index),
            )));

    isActivityLoading.value = false;
  }

  void _fetchMoreNotifications() async {
    if (isNotificationLoading.value) return;

    isNotificationLoading.value = true;
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    // Add more dummy notifications
    notifications.addAll(List.generate(
        10,
        (index) => NotificationModel(
              id: 'NT${notifications.length + index}',
              content: _getRandomNotificationContent(index),
              timestamp: DateTime.now()
                  .subtract(Duration(days: notifications.length ~/ 2 + index)),
            )));

    isNotificationLoading.value = false;
  }

  // Helper methods for generating random data
  String _getRandomActivityType(int index) {
    final types = [
      'Login',
      'Chat Created',
      'Profile Pic Changed',
      'Password Updated',
      'Device Login'
    ];
    return types[index % types.length];
  }

  String _getRandomNotificationContent(int index) {
    final contents = [
      'Your profile is under review',
      'New message received',
      'Security update available',
      'Transaction completed',
      'Profile update successful'
    ];
    return contents[index % contents.length];
  }

  // Export methods
  void exportTransactions() {
    // Implement CSV or PDF export logic
    print('Exporting Transactions');
  }

  void exportActivityLogs() {
    // Implement CSV or PDF export logic
    print('Exporting Activity Logs');
  }

  void onApprove() {
  }

  void onPending() {
  }

  void onRemove() {
  }
}

// Existing ProfileData model (you can expand this)
class ProfileData {
  final String fullName;
  final String email;
  final String dob;
  final String gender;
  final String phone;
  final String address;
  final String selfiePath;
  final String frontIdPath;
  final String backIdPath;

  // Add other profile fields as needed

  ProfileData({
    required this.fullName,
    required this.email,
    required this.dob,
    required this.gender,
    required this.phone,
    required this.address,
    required this.selfiePath,
    required this.frontIdPath,
    required this.backIdPath,
  });
}