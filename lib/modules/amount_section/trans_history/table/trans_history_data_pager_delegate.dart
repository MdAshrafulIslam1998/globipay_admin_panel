import 'package:globipay_admin_panel/modules/amount_section/trans_history/controller/trans_history_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/active_users_new/controller/active_users_new_controller.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TransHistoryDataPagerDelegate extends DataPagerDelegate {
  final TransactionHistoryController controller;

  TransHistoryDataPagerDelegate(this.controller);

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    try {
      await controller.fetchTransactions(newPageIndex + 1, controller.pageSize.value);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  int get rowCount => controller.totalItems.value;

  @override
  int get pageCount =>
      rowCount > 0 ? (rowCount / controller.pageSize.value).ceil() : 0;

  @override
  int get pageSize => controller.pageSize.value;
}