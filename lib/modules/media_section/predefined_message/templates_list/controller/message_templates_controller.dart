import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/core/data/model/pagination_request.dart';
import 'package:globipay_admin_panel/core/utils/custom_dialog.dart';
import 'package:globipay_admin_panel/data/repository/app_repository.dart';
import 'package:globipay_admin_panel/entity/response/messages_templates/message_templates_item_entity.dart';
import 'package:globipay_admin_panel/entity/response/messages_templates/messages_templates_response_entity.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:globipay_admin_panel/router/route_path.dart';

class MessageTemplatesController extends BaseController {
  // Notification Creation Form Controllers
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageUrlController = TextEditingController();

  final AppRepository _appRepository;
  // Observable state variables
  final RxList<MessageTemplatesItemEntity> templates = <MessageTemplatesItemEntity>[].obs;

  final RxString searchQuery = ''.obs;

  MessageTemplatesController(this._appRepository);
  @override
  void onInit() {
    super.onInit();
    requestForTemplates();
  }

  navigateToAddTemplated() {
    AppRoutes.pushNamed(RoutePath.addMessageTemplates).then((value) {
      requestForTemplates();
    });
  }
  // Filtered notifications based on search query
  List<MessageTemplatesItemEntity> get filteredMessagesTemplates {
    if (searchQuery.value.isEmpty) {
      return templates;
    }
    return templates.where((notification) =>
    notification.title.toString().toLowerCase().contains(searchQuery.value.toLowerCase()) ||
        notification.description.toString().toLowerCase().contains(searchQuery.value.toLowerCase())
    ).toList();
  }

  // Search users
  List<MessageTemplatesItemEntity> searchUsers(String query) {
    return templates.where((user) =>
    user.title.toString().toLowerCase().contains(query.toLowerCase()) ||
        user.description.toString().toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  void removeMessageTemplate(String id) {
    showCustomDialog(
      "Are you sure you want to remove this message template?",
      positiveButtonAction: () {
        removeMessageTemplates(id);
      },
      positiveButtonText: "Yes",
      negativeButtonText: "No",
      negativeButtonAction: () {
        AppRoutes.pop();
      },
    );

  }

  void addSelectedTemplates(MessageTemplatesItemEntity user) {

  }

  PaginationRequest generatePaginationRequest() {
    return PaginationRequest(
      page: 1,
      limit: 100,
    );
  }

  parseTemplates(MessagesTemplatesResponseEntity response){
    templates.clear();
    templates.value = response.templates ?? [];
  }

  requestForTemplates(){
    final req = _appRepository.requestForMessageTemplates(generatePaginationRequest());
    callService(
      req,
      onSuccess: (response) {
        parseTemplates(response);
      },
    );
  }

  void removeMessageTemplates(String id) {
    final req = _appRepository.requestToRemoveMessageTemplates(id);
    callService(
      req,
      onSuccess: (response) {
        showCustomDialog(
          "Message Template Removed Successfully",
          positiveButtonAction: () {
            AppRoutes.pop();
          },
          positiveButtonText: "Ok",
        );
        requestForTemplates();
      },
    );
  }

}
