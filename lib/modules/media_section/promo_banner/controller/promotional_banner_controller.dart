import 'dart:io';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/data/models/promotional_banner_model.dart';
import 'package:image_picker/image_picker.dart';

import '../service/promotional_banner_service.dart';

class PromotionalBannerController extends BaseController {
  final PromotionalBannerService _service = PromotionalBannerService();

  // Observable list of banners
  final RxList<PromotionalBannerModel> banners = <PromotionalBannerModel>[].obs;

  // Loading and error states
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // Image picker
  final ImagePicker _picker = ImagePicker();
  final Rx<File?> selectedImage = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchActiveBanners();
  }

  // Fetch active banners
  Future<void> fetchActiveBanners() async {
    try {
      isLoading.value = true;
      banners.value = await _service.getActiveBanners();
    } catch (e) {
      errorMessage.value = 'Failed to load banners';
    } finally {
      isLoading.value = false;
    }
  }

  // Pick image from gallery
  Future<void> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
      }
    } catch (e) {
      errorMessage.value = 'Failed to pick image';
    }
  }

  // Add new promotional banner
  Future<bool> addPromotionalBanner({
    required String title,
    required String description,
    required String backgroundColor,
    required DateTime startDate,
    required DateTime endDate,
    bool isVisibleToAll = true,
    int priority = 0,
    String? destinationUrl,
  }) async {
    try {
      isLoading.value = true;

      final banner = PromotionalBannerModel(
        title: title,
        description: description,
        backgroundColor: backgroundColor,
        imageFile: selectedImage.value,
        startDate: startDate,
        endDate: endDate,
        isVisibleToAll: isVisibleToAll,
        priority: priority,
        destinationUrl: destinationUrl,
      );

      final success = await _service.addPromotionalBanner(banner);

      if (success) {
        // Reset selected image and refresh banners
        selectedImage.value = null;
        await fetchActiveBanners();
      }

      return success;
    } catch (e) {
      errorMessage.value = 'Failed to add banner';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Delete banner
  Future<bool> deleteBanner(String bannerId) async {
    try {
      isLoading.value = true;
      final success = await _service.deletePromotionalBanner(bannerId);

      if (success) {
        // Remove from local list
        banners.removeWhere((banner) => banner.id == bannerId);
      }

      return success;
    } catch (e) {
      errorMessage.value = 'Failed to delete banner';
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}