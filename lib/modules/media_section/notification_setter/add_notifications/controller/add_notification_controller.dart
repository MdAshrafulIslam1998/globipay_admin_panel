import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/core/data/model/pagination_request.dart';
import 'package:globipay_admin_panel/core/di/injector.dart';
import 'package:globipay_admin_panel/core/services/navigator/app_navigator_service.dart';
import 'package:globipay_admin_panel/core/widgets/dropdown/searchable_dropdown.dart';
import 'package:globipay_admin_panel/data/repository/app_repository.dart';
import 'package:globipay_admin_panel/entity/request/notification/create_notification_request_entity.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_item_entity.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class AddNotificationController extends BaseController {
  final titleController = TextEditingController();
  final descriptionController = quill.QuillController.basic();
  final scheduleDateController = TextEditingController();
  final TextEditingController userSearchController = TextEditingController();

  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxBool isScheduled = false.obs;
  final Rx<DateTime?> scheduledDateTime = Rx<DateTime?>(null);
  final RxInt notificationPriority = 1.obs; // 1-3 priority levels
  RxString selectedState = RxString('');
  var selectedUserEntity = Rx<UserResponseItemEntity?>(null);

  final AppRepository appRepository;
  AddNotificationController(this.appRepository);

  late final userController;

  var selectedImageBytes = Rxn<Uint8List>();

  String? uploadImagePath = '';

  @override
  void onInit() {
    userController = SearchableDropdownController.create<UserResponseItemEntity>(
      fetchData: (query, page) async {
        // Make an actual API call
        try {
          final response = await requestForAllUsers(query: query, page: page);
          return response;
        } catch (error) {
          print('Error fetching users: $error');
          return [];
        }
      },
      config:  SearchableDropdownConfig(
        showSearchBox: true,
        isPaginationEnabled: true,
        maxSelectedItems: 3,
      ),
    );
    super.onInit();
  }

  void createNotification() async{
    // Validation and creation logic
    if (titleController.text.isEmpty) {
      showSnackBar(message: 'Title is required');
      return;
    }

    if (descriptionController.document.toPlainText().isEmpty) {
      showSnackBar(message: 'Description is required');
      return;
    }


    if(selectedImageBytes.value != null) {
      uploadImagePath = await requestToUploadByteImage(imageFileBytes: selectedImageBytes.value!);
    }

    if(selectedUserEntity.value == null) {
      showSnackBar(message: 'Please select a user first');
      return;
    }

    triggerNotification();




  }

  CreateNotificationRequestEntity createNotificationRequestEntity() {
    return CreateNotificationRequestEntity(
      title: titleController.text,
      details: descriptionController.document.toPlainText(),
      richMediaUrl: uploadImagePath ?? "",
      userId: selectedUserEntity.value?.userId.toString(),
      token: selectedUserEntity.value?.pushToken.toString(),
      deepLink: '',
    );
  }

  void setSelectedUsers(List<UserResponseItemEntity> selectedUsers) {
    selectedUserEntity.value = selectedUsers.first;
  }

  PaginationRequest userPagination(String? search,{int? page = 1, int? limit = 10}) {
    return PaginationRequest(
      page: page,
      limit: limit,
      query: search,
    );
  }



  // Network Call
  Future<List<UserResponseItemEntity>> requestForAllUsers(
      {String? query,int? page ,int? limit}) async {
    Completer<List<UserResponseItemEntity>> completer = Completer();
    final response = await appRepository.requestForSearchUserList(userPagination(
        query,
      page: page ,
      limit: limit ,
    ));
    completer.complete(response.users ?? []);
    return completer.future;
  }

  void triggerNotification(){
    final req = createNotificationRequestEntity();
    final repo = appRepository.requestToTriggerNotification(req);
    callService(repo, onSuccess: (data) {
      showSnackBar(message: 'Notification sent successfully', status: SnackBarStatus.SUCCESS);
      AppRoutes.pop();
      AppRoutes.pop();
    }, onError: (error) {
      showSnackBar(message: 'Failed to send notification', status: SnackBarStatus.ERROR);
    });

  }
}
