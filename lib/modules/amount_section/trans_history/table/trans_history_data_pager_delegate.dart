import 'package:globipay_admin_panel/core/widgets/app_print.dart';
import 'package:globipay_admin_panel/modules/amount_section/trans_history/controller/trans_history_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/active_users_new/controller/active_users_new_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/blocked_users/controller/blocked_users_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/pending_users/controller/pending_users_controller.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TransHistoryDataPagerDelegate extends DataPagerDelegate {
  final TransHistoryController controller;

  TransHistoryDataPagerDelegate(this.controller);

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    appPrint("Page change requested from $oldPageIndex to $newPageIndex");
    try {
      await controller.fetchTransactionHistory(newPageIndex + 1, controller.pageSize.value);
      appPrint("Page change successful to ${newPageIndex + 1}");
      return true;
    } catch (e) {
      appPrint("Error handling page change: $e");
      return false;
    }
  }

  @override
  int get rowCount {
    appPrint("Total row count requested: ${controller.totalItems.value}");
    return controller.totalItems.value;
  }

  @override
  int get pageCount {
    int pageCount = rowCount > 0 ? (rowCount / controller.pageSize.value).ceil() : 0;
    appPrint("Calculated page count: $pageCount");
    return pageCount;
  }

  @override
  int get pageSize => controller.pageSize.value;
}
