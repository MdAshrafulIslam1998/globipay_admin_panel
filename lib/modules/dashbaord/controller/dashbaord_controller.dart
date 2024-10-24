import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';

class DashboardController extends BaseController {
  var selectedIndex = 0.obs;
  
  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}