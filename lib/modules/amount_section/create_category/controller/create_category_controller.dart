import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/modules/amount_section/create_category/category.dart';
import 'package:globipay_admin_panel/modules/amount_section/create_category/category_response.dart';

class CreateCategoryController extends BaseController {
  var categories = <Category>[].obs;
  var totalItems = 0.obs;
  var currentPage = 1.obs;
  var pageSize = 15.obs;
  var isLoading = false.obs;

  // For new category form
  final categoryNameController = TextEditingController();
  var selectedImagePath = ''.obs;

  Future<void> fetchCategories(int page, int limit) async {
    try {
      isLoading.value = true;
      // Simulated delay to mimic an API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock response data
      var mockResponse = {
        "responseCode": "S100000",
        "responseMessage": "Categories fetched successfully",
        "data": {
          "categories": [
            {
              "id": 1,
              "name": "Zelle",
              "image":
                  "https://img.icons8.com/?size=512&id=Iirw95F6Nl9c&format=png",
              "created_by": "your_user_id"
            },
            {
              "id": 2,
              "name": "Cash app",
              "image":
                  "https://pbs.twimg.com/profile_images/1835765367366422528/Kh5n4dTt_400x400.jpg",
              "created_by": "your_user_id"
            },
            {
              "id": 3,
              "name": "GPay",
              "image":
                  "https://static.vecteezy.com/system/resources/previews/013/948/549/non_2x/google-logo-on-transparent-white-background-free-vector.jpg",
              "created_by": "Admin"
            },
            {
              "id": 15,
              "name": "Apple Pay",
              "image":
                  "https://cdn.iconscout.com/icon/free/png-512/free-apple-pay-logo-icon-download-in-svg-png-gif-file-formats--payment-method-social-media-pack-design-development-icons-4069416.png?f=webp&w=256",
              "created_by": "your_user_id"
            }
          ],
          "pagination": {
            "total": 4,
            "total_pages": 1,
            "current_page": page,
            "limit": limit
          }
        }
      };

      var categoryResponse = CategoryResponse.fromJson(mockResponse);
      if (categoryResponse != null) {
        categories.assignAll(categoryResponse.categories);
        totalItems.value = categoryResponse.pagination.total;
        currentPage.value = categoryResponse.pagination.currentPage;
      }
    } catch (e) {
      print("Error fetching categories: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void updatePageSize(int newSize) {
    pageSize.value = newSize;
    fetchCategories(1, newSize);
  }

  void pickImage() async {
    // Mock image picking
    print('Image picker opened');
    selectedImagePath.value = 'Mocked image path';
  }

  void createCategory() {
    if (categoryNameController.text.isEmpty) {
      print('Category name cannot be empty');
      return;
    }
    print('New category created: ${categoryNameController.text}');
    categoryNameController.clear();
    selectedImagePath.value = '';
    fetchCategories(currentPage.value, pageSize.value); // Refresh the list
  }

  void deleteCategory(int id) {
    print('Category deleted: $id');
    fetchCategories(currentPage.value, pageSize.value); // Refresh the list
  }

  @override
  void onInit() {
    super.onInit();
    fetchCategories(currentPage.value, pageSize.value);
  }

  @override
  void onClose() {
    categoryNameController.dispose();
    super.onClose();
  }
}
