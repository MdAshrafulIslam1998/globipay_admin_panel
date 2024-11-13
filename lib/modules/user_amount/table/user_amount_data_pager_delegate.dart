import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../controller/user_amount_controller.dart';


class UserAmountDataPagerDelegate extends DataPagerDelegate {
  final UserAmountController controller;

  UserAmountDataPagerDelegate(this.controller);

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    try {
      await controller.fetchUserAmounts(newPageIndex + 1, controller.pageSize.value);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  int get rowCount => controller.totalItems.value;

  @override
  int get pageCount => rowCount > 0 ? (rowCount / controller.pageSize.value).ceil() : 0;

  @override
  int get pageSize => controller.pageSize.value;
}
