import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/constants/enum/feature_code.dart';
import 'package:globipay_admin_panel/data/models/misc_item_model.dart';
import 'package:globipay_admin_panel/data/repository/app_repository.dart';
import 'package:globipay_admin_panel/entity/request/misc/add_misc_request_entity.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

/**
 * Created by Abdullah on 14/12/24.
 */


class AddMiscController extends BaseController{
  final titleController = TextEditingController();
  final descriptionController = quill.QuillController.basic();

  final AppRepository appRepository;
  var list = <MiscellaneousItemModel>[].obs;
  Rxn<MiscellaneousItemModel?> selectedCategory = Rxn<MiscellaneousItemModel?>(null);

  AddMiscController(this.appRepository);

  @override
  void onInit() {
    fetchMiscItems();
    super.onInit();
  }

  void fetchMiscItems() {
    var temp = <MiscellaneousItemModel>[];
    temp.add(MiscellaneousItemModel(
      title: FeatureCode.PRIVACY_POLICY.title,
      description: 'Privacy Policy Description',
      code: FeatureCode.PRIVACY_POLICY.code,
    ));
    temp.add(MiscellaneousItemModel(
      title: FeatureCode.TERMS_AND_CONDITIONS.title,
      description: 'Terms & Conditions Description',
      code: FeatureCode.TERMS_AND_CONDITIONS.code,

    ));
    temp.add(MiscellaneousItemModel(
      title: FeatureCode.ABOUT_US.title,
      description: 'About Us Description',
      code: FeatureCode.ABOUT_US.code,

    ));
    temp.add(MiscellaneousItemModel(
      title: FeatureCode.LEVEL.title,
      code: FeatureCode.LEVEL.code,
    ));
    list.value = temp;
    selectedCategory.value = list.first;
  }

  void setSelectedCategory(MiscellaneousItemModel? value) {
    if (value != null) {
      selectedCategory.value = value;
    }
  }
  
  AddMiscRequestEntity addMiscRequestEntity(){
    return AddMiscRequestEntity(
      type: titleController.text,
      content: descriptionController.document.toPlainText().trim(), // Plain text
      featureCode: selectedCategory.value?.code,
    );
  }

  void addMiscItem() {

    if (titleController.text.isEmpty) {
      showSnackBar( message: 'Please enter title',status: SnackBarStatus.INFO);
      return;
    }

    if (descriptionController.document.isEmpty()) {
      showSnackBar( message: 'Please enter description',status: SnackBarStatus.INFO);
      return;
    }

    if(selectedCategory.value == null){
      showSnackBar( message: 'Please select a category',status: SnackBarStatus.INFO);
      return;
    }

    requestForAddMiscItem();
  }



  // Network call

  void requestForAddMiscItem() {
    final repo = appRepository.requestToAddMisc(addMiscRequestEntity());
    callService(
      repo,
      onSuccess: (response) {
        showSnackBar( message: 'Miscellaneous item added successfully',status: SnackBarStatus.SUCCESS);
       AppRoutes.pop();
      },
    );
  }
}