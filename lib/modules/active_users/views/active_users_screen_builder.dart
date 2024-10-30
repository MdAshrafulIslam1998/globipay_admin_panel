import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:globipay_admin_panel/core/base/base_view.dart'; // Update import to include CellButtonModel
import 'package:globipay_admin_panel/core/data/model/data_table/table_button_model.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_column_model.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_pagination_model.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_search_model.dart';
import 'package:globipay_admin_panel/core/widgets/data_table/enhanced_data_table.dart';
import 'package:globipay_admin_panel/modules/active_users/controller/active_users_controller.dart';

class ActiveUsersScreenBuilder extends BaseView<ActiveUsersController> {
  ActiveUsersScreenBuilder({Key? key}) : super(key: key) {
    controller.onInit();
  }

  List<TableColumnModel> get _columns => [
        TableColumnModel(
          label: 'ID',
          key: 'id',
          sortable: true,
        ),
        TableColumnModel(
          label: 'Name',
          key: 'name',
          sortable: true,
        ),
        TableColumnModel(
          label: 'Email',
          key: 'email',
          sortable: true,
        ),
        TableColumnModel(
          label: 'Status',
          key: 'status',
          sortable: true,
        ),
        TableColumnModel(
          label: 'Last Active',
          key: 'lastActive',
          sortable: true,
        ),
        TableColumnModel(
          label: 'Role',
          key: 'role',
          sortable: true,
        ),
        TableColumnModel(
          label: 'Activity Count',
          key: 'activityCount',
          sortable: true,
        ),
        TableColumnModel(
          label: 'Actions',
          key: 'actions',
          sortable: false,
        ),
        TableColumnModel(
          label: 'Messege',
          key: 'messege',
          sortable: false,
        ),
      ];

  List<TableButtonModel> get _exportButtons => [
        TableButtonModel(
          text: 'Export Excel',
          icon: SvgPicture.asset(
            'assets/icons/excel_light.svg',
            height: 15, // Adjust height as necessary
            width: 15, // Adjust width as necessary
            color: Colors.green, // Set the desired color here
          ),
          backgroundColor: Colors.green.shade50,
          textColor: Colors.green,
          onPressed: controller.exportToExcel,
        ),
        TableButtonModel(
          text: 'Export PDF',
          icon: SvgPicture.asset(
            'assets/icons/pdf_light.svg',
            height: 18, // Adjust height as necessary
            width: 18, // Adjust width as necessary
            color: Colors.red, // Set the desired color here
          ),
          backgroundColor: Colors.red.shade50,
          textColor: Colors.red,
          onPressed: controller.exportToPDF,
        ),
      ];

  @override
  Widget body(BuildContext context) {
    return Obx(() => EnhancedDataTable(
          title: 'Active Users Management',
          columns: _columns,
          data: controller.tableData.value,
          exportButtons: _exportButtons,
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
