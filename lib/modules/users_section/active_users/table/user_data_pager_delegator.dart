import 'package:globipay_admin_panel/modules/users_section/active_users/controller/active_users_controller.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UserDataPagerDelegate extends DataPagerDelegate {
  final ActiveUsersController userController;

  UserDataPagerDelegate(this.userController);

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    try {
      // Fetch new data based on the new page index
      await userController.fetchUsers(
          newPageIndex + 1, userController.pageSize.value);
      return true; // Indicate that the page change was successful
    } catch (e) {
      // Handle any error that might occur during the fetch
      return false; // Indicate that the page change failed
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
