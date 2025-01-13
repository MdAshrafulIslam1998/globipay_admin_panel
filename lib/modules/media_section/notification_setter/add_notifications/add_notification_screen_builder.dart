import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/base/base_view.dart';
import 'package:globipay_admin_panel/core/base/base_view_state.dart';
import 'package:globipay_admin_panel/core/constants/app_spaces.dart';
import 'package:globipay_admin_panel/core/theme/color_palettes.dart';
import 'package:globipay_admin_panel/core/widgets/dropdown/app_drop_down.dart';
import 'package:globipay_admin_panel/core/widgets/dropdown/searchable_dropdown.dart';
import 'package:globipay_admin_panel/core/widgets/web_image/web_image.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_item_entity.dart';
import 'package:globipay_admin_panel/modules/media_section/notification_setter/add_notifications/controller/add_notification_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

import '../../../../core/widgets/dropdown/searchable_ovellay_dropdown.dart';

/// Created by Abdullah on 14/12/24.

class AddNotificationScreenBuilder extends StatefulWidget {
  const AddNotificationScreenBuilder({super.key});

  @override
  State<AddNotificationScreenBuilder> createState() =>
      _AddNotificationScreenBuilderState();
}

class _AddNotificationScreenBuilderState extends BaseViewState<
    AddNotificationScreenBuilder, AddNotificationController> {
  @override
  void initState() {
    controller.onInit();
    super.initState();
  }

  @override
  Widget body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Notification',
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
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InkWell(
                    onTap: () {
                      showSearchableDropdown();
                    },
                    child: Obx(
                      () => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            width: 1,
                            color: ColorPalettes.colorPrimary,
                          ),
                        ),
                        padding: const EdgeInsets.all(6),
                        margin: const EdgeInsets.all(8),
                        child: Text(
                          controller.selectedUserEntity.value != null
                              ? controller.selectedUserEntity.value?.name ?? ""
                              : 'Choose users from here ',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  AppSpaces.spaceBetweenItem,
                  _buildTitleField(),
                  AppSpaces.spaceBetweenItem,
                  _buildRichTextEditor(),
                  AppSpaces.spaceBetweenItem,
                  _buildImageUrlLinkField(),
                  AppSpaces.spaceBetweenItem,
                  _buildImageUploader(),
                  AppSpaces.spaceBetweenItem,
                  _buildSubmitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return TextFormField(
      controller: controller.titleController,
      decoration: InputDecoration(
        labelText: 'Notification Title',
        prefixIcon: const Icon(Icons.title),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter notification title';
        }
        return null;
      },
      style: const TextStyle(fontSize: 16),
    );
  }

  Widget _buildImageUrlLinkField() {
    return TextFormField(
      controller: controller.imageUrlLink,
      decoration: InputDecoration(
        labelText: 'Notification Image Url(Optional)',
        prefixIcon: const Icon(Icons.link_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      style: const TextStyle(fontSize: 16),
      onChanged: (value) {
        controller.selectedImageBytes.value = null;
      },
    );
  }

  Widget _buildRichTextEditor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          child: quill.QuillToolbar.simple(
            controller: controller.descriptionController,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          child: quill.QuillEditor.basic(
            controller: controller.descriptionController,
            configurations: const quill.QuillEditorConfigurations(
              padding: EdgeInsets.all(8),
              placeholder: 'Write your notification description...',
              showCursor: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageUploader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Notification Image (Optional)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        WebImagePicker(
          onImageSelected: (images, file) {
            controller.selectedImageBytes.value = images;
          },
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: controller.createNotification,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text(
        'Create Notification',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  void showSearchableDropdown() {
    // Create controller

    // Show dropdown overlay
    SearchableDropdownOverlay.show<UserResponseItemEntity>(
      context: context,
      controller: controller.userController,
      title: 'Select Users',
      itemBuilder: (item) => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorPalettes.colorPrimary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          title: Text(item.name ?? ''),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Email : ${item.email ?? ""}"),
              Text("Gender : ${item.gender ?? ""}"),
              Text("Address : ${item.address ?? ""}"),
            ],
          ),
          trailing: Text(item.status ?? ''),
        ),
      ),
      onChanged: (selectedUsers) {
        controller.setSelectedUsers(selectedUsers);
      },
      displayStringForItemSelection: (UserResponseItemEntity item) {
        return Container(
            color: ColorPalettes.colorPrimary.withOpacity(0.1),
            child: ListTile(
              title: Text(item.name ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email : ${item.email ?? ""}"),
                  Text("Gender : ${item.gender ?? ""}"),
                  Text("Address : ${item.address ?? ""}"),
                ],
              ),
              trailing: Text(item.status ?? ''),
            ));
      },
    );
  }

}
