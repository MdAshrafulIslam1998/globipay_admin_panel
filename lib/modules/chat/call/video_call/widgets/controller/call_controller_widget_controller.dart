import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';

/// Created by Abdullah on 27/10/24.


class CallControllerWidgetController extends GetxController {
   RxBool isMuted = false.obs;
   RxBool isCameraOff = false.obs;
   RxBool isFrontCamera = true.obs;

  void toggleMute() {
    isMuted.value = !isMuted.value;
  }

  void toggleCamera() {
    isCameraOff.value = !isCameraOff.value;
  }

  void switchCamera() {
    isFrontCamera.value = !isFrontCamera.value;
  }
}