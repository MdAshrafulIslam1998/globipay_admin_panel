import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:globipay_admin_panel/core/base/base_view.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_button_model.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_column_model.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_pagination_model.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_search_model.dart';
import 'package:globipay_admin_panel/core/widgets/data_table/enhanced_data_table.dart';
import 'package:globipay_admin_panel/modules/edit_coin/controller/edit_coin_controller.dart';

class EditCoinScreenBuilder extends BaseView<EditCoinController> {
  EditCoinScreenBuilder({Key? key}) : super(key: key) {
    controller.onInit();
  }

  List<TableColumnModel> get _columns => [
        TableColumnModel(
          label: 'Full Name',
          key: 'fullName',
          sortable: true,
        ),
        TableColumnModel(
          label: 'Email',
          key: 'email',
          sortable: true,
        ),
        TableColumnModel(
          label: 'Amount',
          key: 'amount',
          sortable: true,
        ),
        TableColumnModel(
          label: 'Status',
          key: 'status',
          sortable: true,
        ),
        TableColumnModel(
          label: 'Edit',
          key: 'edit',
          sortable: false,
        ),
        TableColumnModel(
          label: 'Details',
          key: 'details',
          sortable: false,
        ),
      ];

  List<TableButtonModel> get _buttons => [
        // New buttons: All, $, V, &
        TableButtonModel(
          text: 'All',
          icon: SvgPicture.asset(
            'assets/icons/check_all_light.svg',
            height: 15,
            width: 15,
            color: Colors.green,
          ),
          backgroundColor: Colors.grey.shade200,
          textColor: Colors.black,
          onPressed: () => controller.filterAll(),
        ),
        TableButtonModel(
          text: '\$',
          icon: SvgPicture.asset(
            'assets/icons/dollar_light.svg',
            height: 15,
            width: 15,
            color: Colors.green,
          ),
          backgroundColor: Colors.grey.shade200,
          textColor: Colors.black,
          onPressed: () => controller.filterByDollar(),
        ),
        TableButtonModel(
          text: 'V',
          icon: SvgPicture.asset(
            'assets/icons/repee_light.svg',
            height: 15,
            width: 15,
            color: Colors.green,
          ),
          backgroundColor: Colors.grey.shade200,
          textColor: Colors.black,
          onPressed: () => controller.filterByRupee(),
        ),
        TableButtonModel(
          text: '&',
          icon: SvgPicture.asset(
            'assets/icons/tag_light.svg',
            height: 15,
            width: 15,
            color: Colors.green,
          ),
          backgroundColor: Colors.grey.shade200,
          textColor: Colors.black,
          onPressed: () => controller.filterByTaka(),
        ),
        // Export and PDF buttons
        TableButtonModel(
          text: 'Export Excel',
          icon: SvgPicture.asset(
            'assets/icons/excel_light.svg',
            height: 15,
            width: 15,
            color: Colors.green,
          ),
          backgroundColor: Colors.green.shade50,
          textColor: Colors.green,
          onPressed: controller.exportToExcel,
        ),
        TableButtonModel(
          text: 'Export PDF',
          icon: SvgPicture.asset(
            'assets/icons/pdf_light.svg',
            height: 18,
            width: 18,
            color: Colors.red,
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
          data: controller.getTableData(),
          exportButtons: _buttons,
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
