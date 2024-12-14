import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class AddNotificationController extends BaseController {
  final titleController = TextEditingController();
  final descriptionController = quill.QuillController.basic();
  final scheduleDateController = TextEditingController();

  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxBool isScheduled = false.obs;
  final Rx<DateTime?> scheduledDateTime = Rx<DateTime?>(null);
  final RxInt notificationPriority = 1.obs; // 1-3 priority levels

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  void removeImage() {
    selectedImage.value = null;
  }

  void openDateTimePicker(BuildContext context) async {
    final DateTime? picked = await showDateTimePicker(context);
    if (picked != null) {
      scheduledDateTime.value = picked;
      scheduleDateController.text = DateFormat('yyyy-MM-dd HH:mm').format(picked);
    }
  }

  Future<DateTime?> showDateTimePicker(BuildContext context) async {
    return await showDialog<DateTime>(
      context: context,
      builder: (context) {
        DateTime selectedDate = DateTime.now();
        TimeOfDay selectedTime = TimeOfDay.now();

        return AlertDialog(
          title: Text('Schedule Notification'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CalendarDatePicker(
                initialDate: selectedDate,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 365)),
                onDateChanged: (date) {
                  selectedDate = date;
                },
              ),
              // Use showTimePicker for time selection
              ElevatedButton(
                onPressed: () async {
                  final TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                  );
                  if (time != null) {
                    selectedTime = time;
                  }
                },
                child: Text('Pick Time'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text('Select'),
              onPressed: () {
                final combinedDateTime = DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  selectedDate.day,
                  selectedTime.hour,
                  selectedTime.minute,
                );
                Navigator.of(context).pop(combinedDateTime);
              },
            ),
          ],
        );
      },
    );
  }

  void createNotification() {
    // Validation and creation logic
    if (titleController.text.isEmpty) {
      Get.snackbar('Error', 'Title is required');
      return;
    }

    // Construct notification object
    final notificationData = {
      'title': titleController.text,
      'description': descriptionController.document.toPlainText(),
      'image': selectedImage.value,
      'priority': notificationPriority.value,
      'scheduledDateTime': scheduledDateTime.value,
    };

    // TODO: Implement actual notification sending logic
    print('Notification Data: $notificationData');
    Get.snackbar('Success', 'Notification Created Successfully');
  }
}
