import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:globipay_admin_panel/core/base/base_view_state.dart';
import 'package:globipay_admin_panel/modules/active_users/controller/active_users_controller.dart';
import 'package:globipay_admin_panel/modules/active_users/table/user_data_pager_delegator.dart';
import 'package:globipay_admin_panel/modules/active_users/table/user_data_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ActiveUsersScreenBuilder extends StatefulWidget {
  const ActiveUsersScreenBuilder({super.key});

  @override
  State<ActiveUsersScreenBuilder> createState() =>
      _ActiveUsersScreenBuilderState();
}

class _ActiveUsersScreenBuilderState
    extends BaseViewState<ActiveUsersScreenBuilder, ActiveUsersController> {
  double datapagerHeight = 70.0;

  @override
  void initState() {
    controller.onInit();
    super.initState();
  }




  @override
  Widget body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User DataGrid with DataPager'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Page Size: '),
              Obx(() => DropdownButton<int>(
                value: controller.pageSize.value,
                items: [10, 20, 30].map((size) {
                  return DropdownMenuItem<int>(
                    value: size,
                    child: Text(size.toString()),
                  );
                }).toList(),
                onChanged: (newSize) {
                  if (newSize != null) {
                    controller.pageSize.value = newSize;
                    controller.fetchUsers(1, newSize); // Reset to first page
                  }
                },
              )),
            ],
          ),
          SizedBox(height: 10),
          // DataGrid for displaying user data
          Expanded(
            child: Obx(() => SfDataGrid(
              source: UserDataSource(controller.users),
              columns: [
                GridColumn(
                  columnName: 'id',
                  label: Text('ID', textAlign: TextAlign.center),
                ),
                GridColumn(
                  columnName: 'name',
                  label: Text('Name', textAlign: TextAlign.center),
                ),
                GridColumn(
                  columnName: 'designation',
                  label: Text('Designation', textAlign: TextAlign.center),
                ),
                GridColumn(
                  columnName: 'age',
                  label: Text('Age', textAlign: TextAlign.center),
                ),
              ],
            )),
          ),
          // SfDataPager with delegate
          Obx(() => SfDataPager(
            delegate: UserDataPagerDelegate(controller),
            pageCount: (controller.totalItems.value / controller.pageSize.value).ceilToDouble(),
          )),
        ],
      ),
    );
  }
}

