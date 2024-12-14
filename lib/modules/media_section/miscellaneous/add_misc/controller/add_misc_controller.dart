import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/constants/enum/feature_code.dart';
import 'package:globipay_admin_panel/data/models/misc_item_model.dart';
/**
 * Created by Abdullah on 14/12/24.
 */


class AddMiscController extends BaseController{
  final titleController = TextEditingController();
  final descriptionController = quill.QuillController.basic();

  var list = <MiscellaneousItemModel>[].obs;
  Rxn<MiscellaneousItemModel?> selectedCategory = Rxn<MiscellaneousItemModel?>(null);

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

  void addMiscItem() {

    if (titleController.text.isEmpty) {
      showSnackBar( message: 'Please enter title',status: SnackBarStatus.INFO);
      return;
    }

    if (descriptionController.document.isEmpty()) {
      showSnackBar( message: 'Please enter description',status: SnackBarStatus.INFO);
      return;
    }





  }
}