import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/core/data/local/repository/token_repository.dart';
import 'package:globipay_admin_panel/core/di/injector.dart';
import 'package:globipay_admin_panel/modules/users_section/add_level/controller/level_model.dart';
import 'package:globipay_admin_panel/modules/users_section/add_level/controller/level_service.dart';


class AddLevelController extends BaseController {
  // Dependencies
  final TokenRepository tokenRepository = Injector.resolve<TokenRepository>();
  late final LevelService _levelService;

  // Observable list to track levels
  RxList<LevelModel> levels = <LevelModel>[].obs;
  
  // Loading and error states
  RxBool isLoading = false.obs;
  Rx<String?> errorMessage = Rx<String?>(null);
  
  // Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  // Text controllers for form fields
  final TextEditingController levelNameController = TextEditingController();
  final TextEditingController levelValueController = TextEditingController();
  final TextEditingController minThreshController = TextEditingController();
  final TextEditingController maxThreshController = TextEditingController();

  // Constructor
  AddLevelController() {
    _levelService = LevelService(tokenRepository);
  }

  @override
  void onInit() {
    super.onInit();
    // Fetch existing levels when controller initializes
    fetchLevels();
  }



  // Fetch existing levels from API
  Future<void> fetchLevels() async {
    // Reset error and set loading
    
    errorMessage.value = null;
    isLoading.value = true;

    try {
      final response = await _levelService.fetchLevels();
      levels.value = response.data?.levels ?? [];
    } catch (e) {
      // Handle specific error scenarios
      errorMessage.value = e.toString();
      
      // Show error snackbar
      Get.snackbar(
        'Error', 
        errorMessage.value ?? 'Failed to fetch levels',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Validate and submit new level
  Future<void> addLevel() async {
    // Reset previous error
    errorMessage.value = null;

    // Validate form
    if (formKey.currentState!.validate()) {
      // Set loading state
      isLoading.value = true;

      try {
        // Get user ID from token repository
        final userId = await tokenRepository.getUserID();

        final newLevel = LevelModel(
          levelName: levelNameController.text,
          levelValue: int.parse(levelValueController.text),
          minThresh: double.parse(minThreshController.text),
          maxThresh: double.parse(maxThreshController.text),
          createdBy: userId, // Use actual user ID
        );

        await _levelService.addLevel(newLevel);
        
        // Clear form after successful submission
        _clearForm();
        
        // Refresh levels list
        await fetchLevels();

        // Success notification
        Get.snackbar(
          'Success', 
          'Level added successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } catch (e) {
        // Handle and display specific error
        errorMessage.value = e.toString();
        
        Get.snackbar(
          'Error', 
          errorMessage.value ?? 'Failed to add level',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        // Always set loading to false
        isLoading.value = false;
      }
    }
  }

  // Clear form fields
  void _clearForm() {
    levelNameController.clear();
    levelValueController.clear();
    minThreshController.clear();
    maxThreshController.clear();
  }

  @override
  void onClose() {
    // Dispose controllers to prevent memory leaks
    levelNameController.dispose();
    levelValueController.dispose();
    minThreshController.dispose();
    maxThreshController.dispose();
    super.onClose();
  }
}