import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_view.dart';
import 'package:globipay_admin_panel/core/widgets/text/app_text.dart';
import 'package:globipay_admin_panel/modules/404_not_found/controller/not_found_controller.dart';
import 'package:globipay_admin_panel/modules/dashboard/controller/dashboard_controller.dart';
import 'package:globipay_admin_panel/modules/settings/controller/settings_controller.dart';
import 'package:globipay_admin_panel/modules/transaction_history/controller/transaction_history_controller.dart';

class DashboardScreenBuilder
    extends BaseView<DashboardController> {
  
  DashboardScreenBuilder({Key? key}) : super(key: key) {
    controller.onInit();
  }

  @override
  PreferredSizeWidget? appBar() {
    return AppBar(title: AppText('Dashboard'));
  }
  
  @override
  Widget body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: const Center(
        child: Text('Dashboard Screen'),
      ),
    );
  }

}
