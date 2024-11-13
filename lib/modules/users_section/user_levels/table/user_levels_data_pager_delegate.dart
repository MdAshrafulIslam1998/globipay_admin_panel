import 'package:globipay_admin_panel/modules/users_section/user_levels/controller/user_levels_controller.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UserLevelDataPagerDelegate extends DataPagerDelegate {
  final UserLevelsController userController;

  UserLevelDataPagerDelegate(this.userController);

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
  int get pageCount => rowCount > 0 ? (rowCount / userController.pageSize.value).ceil() : 0;

  @override
  int get pageSize => userController.pageSize.value;
}
