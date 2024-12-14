import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/core/utils/custom_dialog.dart';
import 'package:globipay_admin_panel/data/repository/app_repository.dart';
import 'package:globipay_admin_panel/entity/response/category/category_item_entity.dart';
import 'package:globipay_admin_panel/modules/media_section/message_templates/message_templates_model.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:globipay_admin_panel/router/route_path.dart';

class MessageTemplatesController extends BaseController {
  // Notification Creation Form Controllers
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageUrlController = TextEditingController();

  final AppRepository _appRepository;
  // Observable state variables
  final RxList<MessageTemplatesModel> templates = <MessageTemplatesModel>[].obs;

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
  List<MessageTemplatesModel> get filteredMessagesTemplates {
    if (searchQuery.value.isEmpty) {
      return templates;
    }
    return templates.where((notification) =>
    notification.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
        notification.description.toLowerCase().contains(searchQuery.value.toLowerCase())
    ).toList();
  }

  // Search users
  List<MessageTemplatesModel> searchUsers(String query) {
    return templates.where((user) =>
    user.title.toLowerCase().contains(query.toLowerCase()) ||
        user.description.toLowerCase().contains(query.toLowerCase())
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

  void addSelectedTemplates(MessageTemplatesModel user) {

  }

  requestForTemplates(){
    var list = <MessageTemplatesModel>[];

   // add 10 items to the list
    for (var i = 0; i < 10; i++) {
      list.add(MessageTemplatesModel(
        id: i.toString(),
        title: 'Title $i',
        description: 'Description $i',
        category: CategoryItemEntity(
          id: i,
          name: 'Category $i',
        ),
      ));
    }
    templates.value = list;
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
