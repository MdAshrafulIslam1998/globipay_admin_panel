import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_view.dart';
import 'package:globipay_admin_panel/core/widgets/text/app_text.dart';
import 'package:globipay_admin_panel/modules/transaction_history/controller/transaction_history_controller.dart';

class TransactionHistoryScreenBuilder
    extends BaseView<TransactionHistoryController> {
  
  TransactionHistoryScreenBuilder({Key? key}) : super(key: key) {
    controller.onInit();
  }

  @override
  PreferredSizeWidget? appBar() {
    return AppBar(title: AppText('Transaction History'));
  }
  
  @override
  Widget body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
      ),
      body: const Center(
        child: Text('Transaction History Screen'),
      ),
    );
  }

}
