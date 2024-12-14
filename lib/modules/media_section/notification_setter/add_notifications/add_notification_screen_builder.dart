import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/base/base_view.dart';
import 'package:globipay_admin_panel/core/widgets/web_image/web_image.dart';
import 'package:globipay_admin_panel/modules/media_section/notification_setter/add_notifications/controller/add_notification_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

/**
 * Created by Abdullah on 14/12/24.
 */

class AddNotificationScreenBuilder extends BaseView<AddNotificationController> {

  @override
  Widget body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Notification',
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
                  _buildTitleField(),
                  SizedBox(height: 16),
                  _buildRichTextEditor(),
                  SizedBox(height: 16),
                  _buildImageUploader(),
                  SizedBox(height: 16),
                  _buildPrioritySelector(),
                  SizedBox(height: 16),
                  _buildSchedulingOptions(context),
                  SizedBox(height: 24),
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
    return TextField(
      controller: controller.titleController,
      decoration: InputDecoration(
        labelText: 'Notification Title',
        prefixIcon: Icon(Icons.title),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      style: TextStyle(fontSize: 16),
    );
  }

  Widget _buildRichTextEditor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600
          ),
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
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          child: quill.QuillEditor.basic(
            controller: controller.descriptionController,
            configurations: quill.QuillEditorConfigurations(
              showCursor: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageUploader() {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Notification Image',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600
          ),
        ),
        WebImagePicker(
          onImageSelected: (images ,file){

          },

        ),
        SizedBox(height: 8),
        controller.selectedImage.value == null
            ? ElevatedButton.icon(
          icon: Icon(Icons.cloud_upload),
          label: Text('Upload Image'),
          onPressed: controller.pickImage,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        )
            : Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: FileImage(controller.selectedImage.value!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: CircleAvatar(
                backgroundColor: Colors.red,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: controller.removeImage,
                ),
              ),
            ),
          ],
        ),
      ],
    ));
  }

  Widget _buildPrioritySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Notification Priority',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600
          ),
        ),
        SizedBox(height: 8),
        Obx(() => SegmentedButton<int>(
          segments: [
            ButtonSegment(
              value: 1,
              label: Text('Low'),
              icon: Icon(Icons.low_priority),
            ),
            ButtonSegment(
              value: 2,
              label: Text('Medium'),
              icon: Icon(Icons.low_priority),
            ),
            ButtonSegment(
              value: 3,
              label: Text('High'),
              icon: Icon(Icons.priority_high),
            ),
          ],
          selected: <int>{controller.notificationPriority.value},
          onSelectionChanged: (Set<int> newSelection) {
            controller.notificationPriority.value = newSelection.first;
          },
        )),
      ],
    );
  }

  Widget _buildSchedulingOptions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Schedule Notification',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
              ),
            ),
            Obx(() => Switch(
              value: controller.isScheduled.value,
              onChanged: (bool value) {
                controller.isScheduled.value = value;
              },
            )),
          ],
        ),
        Obx(() => controller.isScheduled.value
            ? TextField(
          controller: controller.scheduleDateController,
          decoration: InputDecoration(
            labelText: 'Scheduled Date & Time',
            prefixIcon: Icon(Icons.calendar_today),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          readOnly: true,
          onTap: () => controller.openDateTimePicker(context),
        )
            : SizedBox.shrink()),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: controller.createNotification,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        'Create Notification',
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}