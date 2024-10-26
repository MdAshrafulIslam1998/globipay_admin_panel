import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_action_model.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_column_model.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_config_model.dart';
import 'package:globipay_admin_panel/core/widgets/data_table/components/table_action_buttons.dart';
import 'package:globipay_admin_panel/core/widgets/data_table/components/table_footer.dart';
import 'package:globipay_admin_panel/core/widgets/data_table/components/table_header.dart';
import 'package:globipay_admin_panel/core/widgets/data_table/controller/table_controller.dart';

class CustomDataTable extends StatelessWidget {
  final List<TableColumnModel> columns;
  final List<dynamic> data;
  final List<TableActionModel> actions;
  final TableConfigModel config;
  final Function(String, dynamic)? onActionPressed;
  
  CustomDataTable({
    Key? key,
    required this.columns,
    required this.data,
    this.actions = const [],
    TableConfigModel? config,
    this.onActionPressed,
  }) : config = config ?? TableConfigModel(),
       super(key: key);
  
  final controller = Get.put(TableController());
  
  @override
  Widget build(BuildContext context) {
    controller.initialize(data, config);
    
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Table header with search and entries per page
          TableHeader(controller: controller, config: config),
          
          // Data table
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(() {
                final paginatedData = controller.getPaginatedData();
                
                return DataTable(
                  columns: [
                    ...columns.where((col) => col.visible).map((column) {
                      return DataColumn(
                        label: Text(column.label),
                        onSort: column.sortable ? 
                               (_, __) => controller.sort(column.key) : null,
                      );
                    }),
                    if (actions.isNotEmpty)
                      DataColumn(label: Text('Actions')),
                  ],
                  rows: paginatedData.map((item) {
                    return DataRow(
                      cells: [
                        ...columns.where((col) => col.visible).map((column) {
                          final value = item[column.key] ?? '';
                          return DataCell(Text('$value'));
                        }),
                        if (actions.isNotEmpty)
                          DataCell(
                            TableActionButtons(
                              rowData: item,
                              actions: actions,
                              onActionPressed: onActionPressed ?? (_, __) {},
                            ),
                          ),
                      ],
                    );
                  }).toList(),
                );
              }),
            ),
          ),
          
          // Footer with pagination
          if (config.showPagination)
            TableFooter(controller: controller),
        ],
      ),
    );
  }
}