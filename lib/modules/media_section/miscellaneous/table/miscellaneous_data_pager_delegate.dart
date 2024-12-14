import 'package:globipay_admin_panel/core/widgets/app_print.dart';
import 'package:globipay_admin_panel/modules/media_section/miscellaneous/controller/miscellaneous_controller.dart';
import 'package:globipay_admin_panel/modules/media_section/miscellaneous/views/miscellaneous_screen.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

/**
 * Created by Abdullah on 14/12/24.
 */

class MiscellaneousDataPagerDelegate extends DataPagerDelegate {
  final MiscellaneousController controller;

  MiscellaneousDataPagerDelegate(this.controller);

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    appPrint("Page change requested from $oldPageIndex to $newPageIndex");
    try {
      await controller.fetchMiscs(newPageIndex + 1, controller.pageSize.value);
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
    int pageCount =
        rowCount > 0 ? (rowCount / controller.pageSize.value).ceil() : 0;
    print("Calculated page count: $pageCount");
    return pageCount;
  }

  @override
  int get pageSize => controller.pageSize.value;
}
