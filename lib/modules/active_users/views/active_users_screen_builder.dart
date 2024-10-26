import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/base/base_view.dart';
import 'package:globipay_admin_panel/core/widgets/data_table/custom_data_table.dart';
import 'package:globipay_admin_panel/modules/active_users/controller/active_users_controller.dart';

class ActiveUsersScreenBuilder
    extends BaseView<ActiveUsersController> {
  ActiveUsersScreenBuilder({Key? key}) : super(key: key) {
    controller.onInit();
  }

  @override
  Widget body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Active Users")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomDataTable(
          columns: controller.columns,
          data: controller.filteredData,
          actions: controller.actions,
          config: controller.tableConfig,
          onActionPressed: controller.onActionPressed,
        ),
      ),
    );
  }
}