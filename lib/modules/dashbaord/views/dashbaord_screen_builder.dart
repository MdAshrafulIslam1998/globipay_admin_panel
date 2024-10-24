import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/base/base_view.dart';
import 'package:globipay_admin_panel/core/constants/app_edge_insets.dart';
import 'package:globipay_admin_panel/core/theme/color_palettes.dart';
import 'package:globipay_admin_panel/core/widgets/text/app_text.dart';
import 'package:globipay_admin_panel/core/widgets/text/app_text_type.dart';
import 'package:globipay_admin_panel/modules/dashbaord/controller/dashbaord_controller.dart';

class DashboardScreenBuilder extends BaseView<DashboardController> {
  DashboardScreenBuilder({Key? key}) : super(key: key) {
    controller.onInit();
  }

  @override
  PreferredSizeWidget? appBar() {
    return AppBar(
      title: AppText(
              'Dashboard',
              color: Colors.white,
            ),
      backgroundColor: ColorPalettes.buttonPrimaryColor,
      elevation: 0,
    );
  }

  @override
  Widget body(BuildContext context) {
    return Row(
      children: [
        // Sidebar placeholder
        Container(
          width: 250,
          color: ColorPalettes.buttonPrimaryColor,
          child: Center( // Removed 'const'
            child: AppText(
              'Sidebar Coming Soon',
              color: Colors.white,
            ),
          ),
        ),
        
        // Main content area
        Expanded(
          child: Container(
            color: Colors.grey[100],
            padding: AppEdgeInsets.all16,
            child: Center( // Removed 'const'
              child: AppText(
                'Dashboard Content Coming Soon',
                type: AppTextType.headlineMedium,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
