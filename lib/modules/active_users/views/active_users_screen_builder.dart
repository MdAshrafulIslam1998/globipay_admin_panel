import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:globipay_admin_panel/core/widgets/data_table/custom_data_table_widget.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/modules/active_users/controller/active_users_controller.dart'; // Ensure Get is imported
// Import controller

class ActiveUsersScreenBuilder extends StatelessWidget {
  const ActiveUsersScreenBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ActiveUsersController controller = Get.put(ActiveUsersController());

    return Scaffold(
      appBar: AppBar(title: const Text('Active Users')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : CustomDataTableWidget(
              columns: controller.columns,
              data: controller.users,
              config: controller.tableConfig,
              customBuilders: controller.customBuilders,
              onSearch: controller.handleSearch,
              onSort: controller.handleSort,
              onPageChange: controller.handlePageChange,
            )),
      ),
    );
  }
}
