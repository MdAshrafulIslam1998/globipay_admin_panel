import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';

class DashboardController extends BaseController {
  var selectedIndex = 0.obs;
  var isSidebarExpanded = true.obs;
  
  void toggleSidebar() {
    isSidebarExpanded.value = !isSidebarExpanded.value;
  }

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}