import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_view.dart';
import 'package:globipay_admin_panel/core/widgets/text_filed/input_field.dart';
import 'package:globipay_admin_panel/core/widgets/text_filed/input_regex.dart';
import 'package:globipay_admin_panel/entity/response/category/category_item_entity.dart';
import 'package:globipay_admin_panel/entity/response/category/category_response.dart';
import 'package:globipay_admin_panel/modules/media_section/message_templates/add_templates/controller/add_templates_controller.dart';

/// Created by Abdullah on 14/12/24.

class AddTemplatesScreenBuilder extends BaseView<AddTemplatesController> {
  AddTemplatesScreenBuilder({super.key}) {
    controller.onInit();
  }

  @override
  Widget body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Templates',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Form(
              key: controller.formKey,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildCategoryDropdown(),
                    const SizedBox(height: 16),
                    _buildTitleField(),
                    const SizedBox(height: 16),
                    _buildMessageDescriptionsField(),
                    const SizedBox(height: 16),
                    _buildSubmitButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return /*InputField(
      controller: controller.titleController,
      prefixIcon: Icon(Icons.title),
      style: TextStyle(fontSize: 16),
      regex: InputRegex.NOT_EMPTY,
      hintText: 'Message Title',
    )*/
      TextFormField(
      controller: controller.titleController,
      decoration: InputDecoration(
        hintText: 'Message Title',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  Widget _buildMessageDescriptionsField() {
    return
    /*TextFormField(
      controller: controller.descriptionController,
      maxLines: 5,
      decoration: InputDecoration(
        hintText: 'Message Descriptions',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12,),
      ),
    );*/
    TextField(
      controller: controller.descriptionController,
      maxLines: 5,
      decoration: InputDecoration(
        labelText: 'Message Descriptions',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      style: const TextStyle(fontSize: 16),
    );
  }

  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Category',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Obx(
          () => DropdownButtonFormField<CategoryItemEntity>(
            value: controller.selectedCategory.value,
            onChanged: (CategoryItemEntity? newValue) {
              controller.setSelectedCategory(
                  newValue); // Use a method in your controller
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            hint: const Text('Select Category'),
            items: controller.list.map((CategoryItemEntity item) {
              return DropdownMenuItem<CategoryItemEntity>(
                value: item,
                child: Text(item.name ?? ""),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: controller.addTemplates,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text(
        'Add Templates',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
