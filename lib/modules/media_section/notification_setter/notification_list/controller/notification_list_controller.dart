import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/core/constants/enum/notification_target_type.dart';
import 'package:globipay_admin_panel/data/repository/app_repository.dart';
import 'package:globipay_admin_panel/entity/response/notification/notification_response_item_entity.dart';
import 'package:globipay_admin_panel/modules/media_section/notification_setter/user_model.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:globipay_admin_panel/router/route_path.dart';

class NotificationsController extends BaseController {
  // Notification Creation Form Controllers
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageUrlController = TextEditingController();

  // Observable state variables
  final RxList<NotificationResponseItemEntity> notifications = <NotificationResponseItemEntity>[].obs;
  final Rx<NotificationTargetType> selectedTargetType =
      NotificationTargetType.ALL.obs;
  final RxString searchQuery = ''.obs;

  final AppRepository appRepository;

  NotificationsController(this.appRepository);
  @override
  void onInit() {
    requestForAllNotifications();
    super.onInit();
  }

  // Filtered notifications based on search query
  List<NotificationResponseItemEntity> get filteredNotifications {
    if (searchQuery.value.isEmpty) {
      return notifications;
    }
    return notifications.where((notification) =>
    (notification.title ?? "").toLowerCase().contains(searchQuery.value.toLowerCase()) ||
        (notification.details ?? "").toLowerCase().contains(searchQuery.value.toLowerCase())
    ).toList();
  }
  void navigateToCreateNotification() {
    AppRoutes.pushNamed(RoutePath.addNotification).then((value) {
      requestForAllNotifications();
    });
  }

  void removeNotification(String id) {
    askForConfirmation(
        onPositiveAction: () {
      requestToDeleteNotifications(id);
    });
  }

  void setTargetType(NotificationTargetType type) {
    selectedTargetType.value = type;
  }

  parseNotification(List<NotificationResponseItemEntity> response){
    notifications.clear();
    notifications.value = response ?? [];
  }

  //Network Call
  void requestForAllNotifications(){
    final repo = appRepository.requestForAllNotifications();
    callService(repo, onSuccess: (response) {
      parseNotification(response);
    });
  }

  void requestToDeleteNotifications(String id){
    final repo = appRepository.requestToRemoveNotification(id);
    callService(repo, onSuccess: (response) {
      requestForAllNotifications();
    });


  }


}