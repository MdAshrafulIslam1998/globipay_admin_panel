import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:globipay_admin_panel/core/base/base_view.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_pagination_model.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_search_model.dart';
import 'package:globipay_admin_panel/core/widgets/data_table/enhanced_data_table.dart';
import 'package:globipay_admin_panel/modules/edit_coin/controller/edit_coin_controller.dart';

class EditCoinScreenBuilder extends BaseView<EditCoinController> {
  EditCoinScreenBuilder({Key? key}) : super(key: key) {
    controller.onInit();
  }

  @override
  Widget body(BuildContext context) {
    return Obx(() => EnhancedDataTable(
          title: 'Active Users Management',
          columns: controller.columns,
          controller: controller.tableController,
          data: controller.tableData.value,
          exportButtons: controller.buttons,
          searchModel: const TableSearchModel(
            placeholder: 'Search users...',
            borderRadius: 8,
          ),
          paginationModel: const TablePaginationModel(
            visiblePages: 5,
            activeColor: Colors.blue,
            textColor: Colors.black87,
          ),
        ));
  }
}
