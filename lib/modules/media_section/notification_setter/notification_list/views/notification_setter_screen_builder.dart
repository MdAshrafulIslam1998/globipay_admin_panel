import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:globipay_admin_panel/core/base/base_view.dart';
import 'package:globipay_admin_panel/core/base/base_view_state.dart';
import 'package:globipay_admin_panel/core/constants/enum/notification_target_type.dart';
import 'package:globipay_admin_panel/core/utils/extensions.dart';
import 'package:globipay_admin_panel/entity/response/notification/notification_response_item_entity.dart';
import 'package:globipay_admin_panel/modules/media_section/notification_setter/notification_list/controller/notification_list_controller.dart';
import 'package:globipay_admin_panel/modules/media_section/notification_setter/user_model.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:globipay_admin_panel/router/route_path.dart';

class NotificationsScreenBuilder extends StatefulWidget {
  const NotificationsScreenBuilder({super.key});

  @override
  State<NotificationsScreenBuilder> createState() =>
      _NotificationsScreenBuilderState();
}

class _NotificationsScreenBuilderState
    extends BaseViewState<NotificationsScreenBuilder, NotificationsController> {
  @override
  void initState() {
    controller.onInit();
    super.initState();
  }

  @override
  Widget body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Management',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          ElevatedButton.icon(
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text('Create Notifications',
                style: TextStyle(color: Colors.white)),
            onPressed: () {
              controller.navigateToCreateNotification();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade600,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: Obx(() => _buildNotificationsList()),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search notifications...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onChanged: (value) => controller.searchQuery.value = value,
      ),
    );
  }

  Widget _buildNotificationsList() {
    final filteredNotifications = controller.filteredNotifications;

    return filteredNotifications.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.notifications_off, size: 100, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  'No Notifications Found',
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: filteredNotifications.length,
            itemBuilder: (context, index) {
              final notification = filteredNotifications[index];
              return _buildNotificationCard(notification);
            },
          );
  }

  Widget _buildNotificationCard(NotificationResponseItemEntity notification) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: notification.richMediaUrl != null
            ? CachedNetworkImage(
                imageUrl: (notification.richMediaUrl ?? "").includeBaseUrl(),
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.image_not_supported),
              )
            : CircleAvatar(
                backgroundColor: Colors.blue[100],
                child: const Icon(Icons.notifications, color: Colors.blue),
              ),
        title: Text(
          notification.title ?? "",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.details ?? "",
              overflow: TextOverflow.ellipsis,
            ),
            _buildTargetBadge(notification),
            Text(
              notification.createdAt ?? "",
              overflow: TextOverflow.ellipsis,
            ),

          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () =>
              controller.removeNotification(notification.notificationId.toString() ?? ""),
          tooltip: 'Remove Notification',
        ),
      ),
    );
  }

  Widget _buildTargetBadge(NotificationResponseItemEntity notification) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: notification.targetType == NotificationTargetType.ALL
            ? Colors.green[100]
            : Colors.blue[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        notification.targetType == NotificationTargetType.ALL
            ? 'All Users'
            : 'Specific Users',
        style: TextStyle(
          fontSize: 12,
          color: notification.targetType == NotificationTargetType.ALL
              ? Colors.green[800]
              : Colors.blue[800],
        ),
      ),
    );
  }
}
