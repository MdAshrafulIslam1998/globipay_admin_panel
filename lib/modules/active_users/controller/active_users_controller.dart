import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/core/data/model/active_user_model.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/cell_button_model.dart';
import 'package:globipay_admin_panel/core/widgets/data_table/controller/enhanced_table_controller.dart';
import 'package:intl/intl.dart'; // Add this line

class ActiveUsersController extends BaseController {
  var featureName = "Active Users";
  final RxList<ActiveUserModel> users = <ActiveUserModel>[].obs;
  final tableController = Get.put(EnhancedTableController());

  @override
  void onInit() {
    super.onInit();
    loadUsers();
  }

  void loadUsers() {
    // Simulating API call with more sample data
    users.value = [
      ActiveUserModel(
        id: 1,
        name: 'John Doe',
        email: 'john@example.com',
        status: 'Online',
        lastActive: DateTime.now(),
        role: 'Admin',
        activityCount: 45,
      ),
      ActiveUserModel(
        id: 2,
        name: 'Jane Smith',
        email: 'jane@example.com',
        status: 'Offline',
        lastActive: DateTime.now().subtract(const Duration(hours: 2)),
        role: 'User',
        activityCount: 32,
      ),
      ActiveUserModel(
        id: 3,
        name: 'Alice Johnson',
        email: 'alice@example.com',
        status: 'Online',
        lastActive: DateTime.now().subtract(const Duration(minutes: 15)),
        role: 'Moderator',
        activityCount: 57,
      ),
      ActiveUserModel(
        id: 4,
        name: 'Bob Brown',
        email: 'bob@example.com',
        status: 'Offline',
        lastActive: DateTime.now().subtract(const Duration(hours: 4)),
        role: 'User',
        activityCount: 20,
      ),
      ActiveUserModel(
        id: 5,
        name: 'Charlie Wilson',
        email: 'charlie@example.com',
        status: 'Online',
        lastActive: DateTime.now().subtract(const Duration(minutes: 5)),
        role: 'Admin',
        activityCount: 75,
      ),
      ActiveUserModel(
        id: 6,
        name: 'Diane Lee',
        email: 'diane@example.com',
        status: 'Offline',
        lastActive: DateTime.now().subtract(const Duration(hours: 6)),
        role: 'User',
        activityCount: 29,
      ),
      ActiveUserModel(
        id: 7,
        name: 'Evelyn King',
        email: 'evelyn@example.com',
        status: 'Online',
        lastActive: DateTime.now().subtract(const Duration(hours: 1)),
        role: 'User',
        activityCount: 48,
      ),
      ActiveUserModel(
        id: 8,
        name: 'Frank Martin',
        email: 'frank@example.com',
        status: 'Offline',
        lastActive: DateTime.now().subtract(const Duration(hours: 7)),
        role: 'Admin',
        activityCount: 61,
      ),
      ActiveUserModel(
        id: 9,
        name: 'Grace Young',
        email: 'grace@example.com',
        status: 'Online',
        lastActive: DateTime.now().subtract(const Duration(minutes: 25)),
        role: 'Moderator',
        activityCount: 83,
      ),
      ActiveUserModel(
        id: 10,
        name: 'Henry Davis',
        email: 'henry@example.com',
        status: 'Offline',
        lastActive: DateTime.now().subtract(const Duration(hours: 10)),
        role: 'User',
        activityCount: 14,
      ),
      ActiveUserModel(
        id: 11,
        name: 'Ivy Gonzalez',
        email: 'ivy@example.com',
        status: 'Online',
        lastActive: DateTime.now().subtract(const Duration(minutes: 30)),
        role: 'User',
        activityCount: 67,
      ),
      ActiveUserModel(
        id: 12,
        name: 'Jack Miller',
        email: 'jack@example.com',
        status: 'Offline',
        lastActive: DateTime.now().subtract(const Duration(hours: 12)),
        role: 'Admin',
        activityCount: 90,
      ),
      ActiveUserModel(
        id: 13,
        name: 'Kathy Anderson',
        email: 'kathy@example.com',
        status: 'Online',
        lastActive: DateTime.now().subtract(const Duration(minutes: 10)),
        role: 'User',
        activityCount: 36,
      ),
      ActiveUserModel(
        id: 14,
        name: 'Leo Perez',
        email: 'leo@example.com',
        status: 'Offline',
        lastActive: DateTime.now().subtract(const Duration(hours: 15)),
        role: 'User',
        activityCount: 25,
      ),
      ActiveUserModel(
        id: 15,
        name: 'Mona Hall',
        email: 'mona@example.com',
        status: 'Online',
        lastActive: DateTime.now().subtract(const Duration(minutes: 20)),
        role: 'Admin',
        activityCount: 78,
      ),
      ActiveUserModel(
        id: 16,
        name: 'Nina Clark',
        email: 'nina@example.com',
        status: 'Offline',
        lastActive: DateTime.now().subtract(const Duration(hours: 16)),
        role: 'User',
        activityCount: 12,
      ),
      ActiveUserModel(
        id: 17,
        name: 'Oscar Lewis',
        email: 'oscar@example.com',
        status: 'Online',
        lastActive: DateTime.now().subtract(const Duration(minutes: 45)),
        role: 'Moderator',
        activityCount: 60,
      ),
      ActiveUserModel(
        id: 18,
        name: 'Paul Walker',
        email: 'paul@example.com',
        status: 'Offline',
        lastActive: DateTime.now().subtract(const Duration(hours: 18)),
        role: 'User',
        activityCount: 11,
      ),
      ActiveUserModel(
        id: 19,
        name: 'Quinn Wright',
        email: 'quinn@example.com',
        status: 'Online',
        lastActive: DateTime.now().subtract(const Duration(minutes: 5)),
        role: 'User',
        activityCount: 65,
      ),
      ActiveUserModel(
        id: 20,
        name: 'Rachel Harris',
        email: 'rachel@example.com',
        status: 'Offline',
        lastActive: DateTime.now().subtract(const Duration(hours: 20)),
        role: 'Admin',
        activityCount: 88,
      ),
    ];

    final tableData = users.map((user) {
      String buttonText =
          getButtonText(user); // Get the button text based on user data

      return user.toMap((id) {
        // Action for the button press can be defined here
        viewUserDetails(id);
      }, buttonText: buttonText); // Pass the button text
    }).toList();

    tableController.initialize(tableData, 10);
  }

  String getButtonText(ActiveUserModel user) {
    // Customize button text based on user properties
    if (user.status == 'Online') {
      return 'Disconnect'; // Example text for online users
    } else {
      return 'Reconnect'; // Example text for offline users
    }
  }

  void viewUserDetails(int userId) {
    // Handle viewing user details
    print('Viewing details for user $userId');
  }

  void exportToExcel() {
    final data = tableController.exportCurrentData();
    // Handle Excel export
    print('Exporting to Excel: $data');
  }

  void exportToPDF() {
    final data = tableController.exportCurrentData();
    // Handle PDF export
    print('Exporting to PDF: $data');
  }
}
