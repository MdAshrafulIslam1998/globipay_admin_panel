import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_view.dart';
import 'package:globipay_admin_panel/core/data/model/common_data_entity.dart';
import 'package:globipay_admin_panel/core/theme/app_colors.dart';
import 'package:globipay_admin_panel/core/widgets/dropdown/app_drop_down.dart';
import 'package:globipay_admin_panel/data/models/misc_item_model.dart';
import 'package:globipay_admin_panel/modules/media_section/miscellaneous/add_misc/controller/add_misc_controller.dart';
import 'package:globipay_admin_panel/modules/media_section/miscellaneous/controller/miscellaneous_controller.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

/**
 * Created by Abdullah on 14/12/24.
 */

class AddMiscItemScreenBuilder extends BaseView<AddMiscController> {

  AddMiscItemScreenBuilder(){
    controller.onInit();
  }

  @override
  Widget body(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        'Create Miscellaneous Item',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.projectButtonBlue2, // Change font color here
        ),
      ),
      elevation: 1,
      backgroundColor: Colors.white, // Change background color here
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: AppColors.projectBlue, // Change card background color here
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16),
                _buildCategoryDropdown(),
                SizedBox(height: 16),
                _buildContentTypeDropdown(),
                SizedBox(height: 16),
                _buildRichTextEditor(),
                SizedBox(height: 16),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Category',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<MiscellaneousItemModel>(
          value: controller.selectedCategory.value,
          onChanged: (MiscellaneousItemModel? newValue) {
            controller.setSelectedCategory(newValue); // Use a method in your controller
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
          ),
          items: controller.list.map((MiscellaneousItemModel item) {
            return DropdownMenuItem<MiscellaneousItemModel>(
              value: item,
              child: Text(item.title ?? ""),
            );
          }).toList(),
        ),
      ],
    );
  }
  Widget _buildContentTypeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Content Type',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<CommonDataEntity>(
          value: controller.selectedContentType.value,
          onChanged: (CommonDataEntity? newValue) {
            controller.setSelectedContentType(newValue); // Use a method in your controller
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
          ),
          items: controller.contentTypes.map((CommonDataEntity item) {
            return DropdownMenuItem<CommonDataEntity>(
              value: item,
              child: Text(item.key ?? ""),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRichTextEditor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          child: quill.QuillToolbar.simple(
            controller: controller.descriptionController,
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 400,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          child: quill.QuillEditor.basic(
            controller: controller.descriptionController,
            configurations: quill.QuillEditorConfigurations(
                showCursor: true, padding: EdgeInsets.all(8)),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: controller.addMiscItem,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.projectButtonBlue2,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        'Add Miscellaneous Item',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
