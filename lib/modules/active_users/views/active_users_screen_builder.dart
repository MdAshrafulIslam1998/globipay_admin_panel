import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:globipay_admin_panel/core/base/base_view.dart';
import 'package:globipay_admin_panel/modules/active_users/controller/active_users_datasource.dart';
import 'package:globipay_admin_panel/modules/edit_coin/controller/edit_coin_datasource.dart';
import 'package:globipay_admin_panel/modules/active_users/controller/active_users_controller.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ActiveUsersScreenBuilder extends BaseView<ActiveUsersController> {
  ActiveUsersScreenBuilder({Key? key}) : super(key: key) {
    controller.onInit();
  }

  @override
  PreferredSizeWidget? appBar() {
    return AppBar(title: Text('Active Users'));
  }

  @override
  Widget body(BuildContext context) {
    return Obx(() {
      // Convert the RxList to a standard List
      List<Map<String, dynamic>> coinsList = controller.coins.toList();

      // Pass the controller and coinsList to the DataGridSource
      return SfDataGrid(
        source: ActiveUsersDatasource(controller, coinsList),  // Pass controller here
        columns: [
          GridColumn(columnName: 'fullName', label: Text('Full Name')),
          GridColumn(columnName: 'email', label: Text('Email')),
          GridColumn(columnName: 'amount', label: Text('Amount')),
          GridColumn(columnName: 'level', label: Text('Level')),
          GridColumn(columnName: 'status', label: Text('Status')),
          GridColumn(columnName: 'edit', label: Text('Edit')),
          GridColumn(columnName: 'details', label: Text('Details')),
        ],
        columnWidthMode: ColumnWidthMode.fill,
      );
    });
  }
}
