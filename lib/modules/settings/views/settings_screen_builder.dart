import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_view.dart';
import 'package:globipay_admin_panel/core/widgets/text/app_text.dart';
import 'package:globipay_admin_panel/modules/404_not_found/controller/not_found_controller.dart';
import 'package:globipay_admin_panel/modules/settings/controller/settings_controller.dart';
import 'package:globipay_admin_panel/modules/transaction_history/controller/transaction_history_controller.dart';

class SettingsScreenBuilder
    extends BaseView<SettingsController> {
  
  SettingsScreenBuilder({Key? key}) : super(key: key) {
    controller.onInit();
  }

  @override
  PreferredSizeWidget? appBar() {
    return AppBar(title: AppText('Settings'));
  }
  
  @override
  Widget body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const Center(
        child: Text('Settings Screen'),
      ),
    );
  }

}
