import 'package:globipay_admin_panel/modules/pending_users/controller/pending_users_controller.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PendingUserDataPagerDelegate extends DataPagerDelegate {
  final PendingUsersController userController;

  PendingUserDataPagerDelegate(this.userController);

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    try {
      await userController.fetchUsers(newPageIndex + 1, userController.pageSize.value);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  int get rowCount => userController.totalItems.value;

   @override
  int get pageCount =>
      rowCount > 0 ? (rowCount / userController.pageSize.value).ceil() : 0;

  @override
  int get pageSize => userController.pageSize.value;
}