import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_config_model.dart';
import 'package:globipay_admin_panel/core/widgets/data_table/controller/table_controller.dart';

class TableHeader extends StatelessWidget {
  final TableController controller;
  final TableConfigModel config;
  
  const TableHeader({
    Key? key,
    required this.controller,
    required this.config,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Entries per page selector
          Row(
            children: [
              const Text('Show'),
              const SizedBox(width: 8),
              Obx(() => DropdownButton<int>(
                value: controller.itemsPerPage.value,
                items: config.rowsPerPageOptions.map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onChanged: (int? value) {
                  if (value != null) controller.updateItemsPerPage(value);
                },
              )),
              const SizedBox(width: 8),
              const Text('entries'),
            ],
          ),
          
          // Search field
          if (config.showSearch)
            SizedBox(
              width: 200,
              child: TextField(
                onChanged: controller.onSearch,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}