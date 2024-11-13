import 'package:globipay_admin_panel/modules/amount_section/create_category/controller/create_category_controller.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CreateCategoryDataPagerDelegate extends DataPagerDelegate {
  final CreateCategoryController controller;

  CreateCategoryDataPagerDelegate(this.controller);

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    try {
      await controller.fetchCategories(newPageIndex + 1, controller.pageSize.value);
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