import 'package:globipay_admin_panel/modules/users_section/active_users_new/controller/active_users_new_controller.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UserDataPagerDelegate extends DataPagerDelegate {
  final ActiveUsersNewController controller;

  UserDataPagerDelegate(this.controller);

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    print("Page change requested from $oldPageIndex to $newPageIndex");
    try {
      await controller.fetchUsers(newPageIndex + 1, controller.pageSize.value);
      print("Page change successful to ${newPageIndex + 1}");
      return true;
    } catch (e) {
      print("Error handling page change: $e");
      return false;
    }
  }

  @override
  int get rowCount {
    print("Total row count requested: ${controller.totalItems.value}");
    return controller.totalItems.value;
  }

  @override
  int get pageCount {
    int pageCount = rowCount > 0 ? (rowCount / controller.pageSize.value).ceil() : 0;
    print("Calculated page count: $pageCount");
    return pageCount;
  }

  @override
  int get pageSize => controller.pageSize.value;
}