import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PromoBannerController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  final RxString imageFileName = ''.obs;
  final RxBool isBannerShowing = false.obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onClose() {
    titleController.dispose();
    bodyController.dispose();
    super.onClose();
  }

  void pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageFileName.value = image.name;
      print("Selected image: ${image.path}");
    } else {
      print("No image selected.");
    }
  }

  void startShowing() {
    isBannerShowing.value = true;
    Get.snackbar(
      'Success',
      'Banner is now showing',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void stopShowing() {
    isBannerShowing.value = false;
    Get.snackbar(
      'Success',
      'Banner has stopped showing',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
