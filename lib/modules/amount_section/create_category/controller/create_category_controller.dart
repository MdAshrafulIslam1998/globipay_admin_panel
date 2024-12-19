import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/core/data/local/repository/token_repository.dart';
import 'package:globipay_admin_panel/core/utils/custom_dialog.dart';
import 'package:globipay_admin_panel/core/utils/extensions.dart';
import 'package:globipay_admin_panel/data/repository/app_repository.dart';
import 'package:globipay_admin_panel/entity/request/category/add_category_request_entity.dart';
import 'package:globipay_admin_panel/entity/response/category/category_item_entity.dart';
import 'package:globipay_admin_panel/entity/response/file_upload/file_upload_response.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'dart:html' as html;
import '../../../../core/data/model/pagination_request.dart';
import '../../../../entity/response/category/category_response.dart';

class CreateCategoryController extends BaseController {
  final categoryNameController = TextEditingController();
  final AppRepository _repository;
  final TokenRepository tokenRepository;
  Uint8List? selectedImageBytes;

  CreateCategoryController(this._repository,this.tokenRepository);

  //Rx Variables
  var categories = <CategoryItemEntity>[].obs;
  var totalItems = 0.obs;
  var currentPage = 1.obs;
  var pageSize = 5.obs;

  Color? categoryColor ;


  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void selectedBytesImage(Uint8List? bytes) {
    selectedImageBytes = bytes;
  }

  PaginationRequest generatePaginationRequest() {
    return PaginationRequest(limit: 200, page: currentPage.value);
  }

  parserCategories(CategoryResponseEntity response) {
    categories.clear();
    categories.value = response.categories ?? [];
  }

  void createCategory() {
    if (categoryNameController.text.isEmpty) {
      showSnackBar(message: 'Brand name cannot be empty');
      return;
    }
    if (selectedImageBytes == null) {
      showSnackBar(message: 'Please select a brand logo');
      return;
    }

    if (categoryColor == null) {
      showSnackBar(message: 'Please select a color');
      return;
    }

    uploadCategoryImage();

  }

  AddCategoryRequestEntity categoryAddRequest(String url, String stiffId) {
    return AddCategoryRequestEntity(
      name: categoryNameController.text,
      image: url,
      bgcolor: categoryColor.colorToHex() ?? '',
      createdBy: stiffId
    );
  }

  void deleteCategory(String id) {
    confirmDelete(id);
  }

  void confirmDelete(String id) {
    showCustomDialog(
      "Are you sure you want to delete this category?",
      positiveButtonAction: () {
        requestToDeleteCategory(id);
      },
      positiveButtonText: "Yes",
      negativeButtonText: "No",
      negativeButtonAction: () {
        AppRoutes.pop();
      },
    );
  }
  parseCategoryImageResponse(FileUploadResponse response) async{
    if(response.url == null){
      showSnackBar(message: 'Could not upload image');
      return;
    }
    final staffId = await tokenRepository.getStuffId();
    requestToAddCategory(categoryAddRequest(response.url!, staffId));
  }

  clearOnSuccess(){
    categoryNameController.clear();
    selectedImageBytes = null;
    categoryColor = null;
    html.window.location.reload();
  }

  //Network Calls

  Future<void> fetchCategories() async {
    final repo = _repository.requestForCategories(generatePaginationRequest());
    callService(repo, onSuccess: (CategoryResponseEntity response) {
      parserCategories(response);
    });
  }

  void uploadCategoryImage() {
    if(selectedImageBytes!=null){
      final req = byteFieUploadRequest(selectedImageBytes!, 'category_image');
      final repo = _repository.requestToByteFileUpload(req);
      callService(repo, onSuccess: (FileUploadResponse response) {
        parseCategoryImageResponse(response);
      });
    }
  }


  requestToAddCategory(AddCategoryRequestEntity req) {
    final repo = _repository.requestToAddCategory(req);
    callService(repo, onSuccess: (response){
      clearOnSuccess();
      showCustomDialog(
        "Category added successfully",
        positiveButtonAction: () {

          AppRoutes.pop();
          fetchCategories();
        },
        positiveButtonText: "Ok",
      );
    });
  }

  void requestToDeleteCategory(String id){
    final repo = _repository.requestToDeleteCategory(id);
    callService(repo, onSuccess: (response){
      showCustomDialog(
        "Category deleted successfully",
        positiveButtonAction: () {
          AppRoutes.pop();
          fetchCategories();
        },
        positiveButtonText: "Ok",
      );
    });
  }




  @override
  void onClose() {
    categoryNameController.dispose();
    super.onClose();
  }
}
