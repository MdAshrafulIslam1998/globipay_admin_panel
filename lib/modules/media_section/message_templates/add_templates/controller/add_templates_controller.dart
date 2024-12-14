import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/core/utils/custom_dialog.dart';
import 'package:globipay_admin_panel/data/repository/app_repository.dart';
import 'package:globipay_admin_panel/entity/request/message_templates/add_message_templates_request.dart';
import 'package:globipay_admin_panel/entity/response/category/category_item_entity.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/entity/response/category/category_response.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';

import '../../../../../core/data/model/pagination_request.dart';
/**
 * Created by Abdullah on 14/12/24.
 */

class AddTemplatesController extends BaseController{
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final AppRepository _appRepository;

  var list = <CategoryItemEntity>[].obs;
  Rxn<CategoryItemEntity?> selectedCategory = Rxn<CategoryItemEntity?>(null);

  AddTemplatesController(this._appRepository);

  @override
  void onInit() {
    super.onInit();
    requestForCategories();
  }


  void setSelectedCategory(CategoryItemEntity? value) {
    if (value != null) {
      selectedCategory.value = value;
    }
  }

  AddMessageTemplatesRequest messageTemplatesRequest ()=> AddMessageTemplatesRequest(
    title: titleController.text,
    message: descriptionController.text,
    category: selectedCategory.value?.id.toString(),
  );

  void addTemplates(){
    if(titleController.text.isEmpty || descriptionController.text.isEmpty || selectedCategory.value == null){
        showSnackBar(
          message: "Please fill all the fields",
          status: SnackBarStatus.ERROR,
        );
        return;
    }
    requestToAddMessageTemplates();

  }

  parseCategory(CategoryResponseEntity response) {
    list.value = response.categories ?? [];
  }

  parseMessageTemplatesResponse(response) {
    showSnackBar(
      message: response.message,
      status: SnackBarStatus.SUCCESS,
    );
    Get.back();
  }

  PaginationRequest generatePaginationRequest() {
    return PaginationRequest(limit: 200, page: 1);
  }

  void requestForCategories() {
    final repo =
    _appRepository.requestForCategories(generatePaginationRequest());
    callService(
      repo,
      onSuccess: (response) {
        parseCategory(response);
      },
    );
  }

  void requestToAddMessageTemplates(){
    final req = messageTemplatesRequest();
    final repo = _appRepository.requestToAddMessageTemplates(req);
    callService(
      repo,
      onSuccess: (response) {
       showCustomDialog("Message Template Added Successfully",
       positiveButtonAction: (){
         AppRoutes.pop();
       },
        positiveButtonText: "Ok",
       );
      },
    );
  }



}