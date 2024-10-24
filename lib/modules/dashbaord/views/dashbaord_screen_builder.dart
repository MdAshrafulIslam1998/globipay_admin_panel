import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:globipay_admin_panel/core/base/base_view.dart';
import 'package:globipay_admin_panel/core/constants/app_edge_insets.dart';
import 'package:globipay_admin_panel/core/widgets/sidebar/sidebar_widget.dart';
import 'package:globipay_admin_panel/core/widgets/text/app_text.dart';
import 'package:globipay_admin_panel/core/widgets/text/app_text_type.dart';
import 'package:globipay_admin_panel/modules/dashbaord/controller/dashbaord_controller.dart';

class DashboardScreenBuilder extends BaseView<DashboardController> {
  DashboardScreenBuilder({Key? key}) : super(key: key) {
    controller.onInit();
  }

  @override
  PreferredSizeWidget? appBar() => null; // Remove AppBar since sidebar has logo

  @override
  Widget body(BuildContext context) {
    return Row(
      children: [
        // Sidebar
        Obx(() => SidebarWidget(
          selectedIndex: controller.selectedIndex,
          isExpanded: controller.isSidebarExpanded.value,
          onMenuToggle: controller.toggleSidebar,
        )),
        
        // Main content area
        Expanded(
          child: Container(
            color: Colors.grey[100],
            padding: AppEdgeInsets.all16,
            child: const Center(
              child: AppText(
                'Dashboard Content Coming Soon',
                type: AppTextType.bodyLarge,
              ),
            ),
          ),
        ),
      ],
    );
  }
}