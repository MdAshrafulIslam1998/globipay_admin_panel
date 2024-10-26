import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:globipay_admin_panel/core/widgets/data_table/controller/table_controller.dart';


class TableFooter extends StatelessWidget {
  final TableController controller;
  
  const TableFooter({
    Key? key,
    required this.controller,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Showing X to Y of Z entries
          Obx(() {
            final start = (controller.currentPage.value - 1) * 
                          controller.itemsPerPage.value + 1;
            final end = start + controller.itemsPerPage.value - 1;
            final total = controller.filteredData.length;
            return Text(
              'Showing $start to ${end > total ? total : end} of $total entries',
            );
          }),
          
          // Pagination controls
          Row(
            children: [
              TextButton(
                onPressed: () {
                  if (controller.currentPage.value > 1) {
                    controller.updatePage(controller.currentPage.value - 1);
                  }
                },
                child: Text('Previous'),
              ),
              Obx(() => Text(
                'Page ${controller.currentPage}',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              TextButton(
                onPressed: () {
                  final maxPages = (controller.filteredData.length / 
                                  controller.itemsPerPage.value).ceil();
                  if (controller.currentPage.value < maxPages) {
                    controller.updatePage(controller.currentPage.value + 1);
                  }
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
