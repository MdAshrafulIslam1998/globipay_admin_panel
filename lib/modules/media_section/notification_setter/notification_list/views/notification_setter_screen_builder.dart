import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:globipay_admin_panel/core/base/base_view.dart';
import 'package:globipay_admin_panel/modules/media_section/notification_setter/notification_list/controller/notification_list_controller.dart';
import 'package:globipay_admin_panel/modules/media_section/notification_setter/user_model.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:globipay_admin_panel/router/route_path.dart';


class NotificationsScreenBuilder extends BaseView<NotificationsController> {

  NotificationsScreenBuilder(){
    controller.onInit();
  }

  @override
  Widget body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Management',
            style: TextStyle(fontWeight: FontWeight.bold)
        ),
        actions: [
          ElevatedButton.icon(
            icon: Icon(Icons.add, color: Colors.white),
            label: Text('Create Notifications', style: TextStyle(color: Colors.white)),
            onPressed: () {
              AppRoutes.pushNamed(RoutePath.addNotification);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade600,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
          prefixIcon: Icon(Icons.search),
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
          Icon(Icons.notifications_off, size: 100, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No Notifications Found',
            style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600]
            ),
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

  Widget _buildNotificationCard(NotificationModel notification) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: notification.imageUrl != null
            ? CachedNetworkImage(
          imageUrl: notification.imageUrl!,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              CircularProgressIndicator(),
          errorWidget: (context, url, error) =>
              Icon(Icons.image_not_supported),
        )
            : CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Icon(Icons.notifications, color: Colors.blue),
        ),
        title: Text(
          notification.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8),
            _buildTargetBadge(notification),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () => controller.removeNotification(notification.id),
          tooltip: 'Remove Notification',
        ),
      ),
    );
  }

  Widget _buildTargetBadge(NotificationModel notification) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: notification.targetType == NotificationTargetType.all
            ? Colors.green[100]
            : Colors.blue[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        notification.targetType == NotificationTargetType.all
            ? 'All Users'
            : 'Specific Users (${notification.specificUserIds?.length ?? 0})',
        style: TextStyle(
          fontSize: 12,
          color: notification.targetType == NotificationTargetType.all
              ? Colors.green[800]
              : Colors.blue[800],
        ),
      ),
    );
  }


  Widget _buildUserSelection() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Search Users',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            // Filtering handled in searchUsers method
          },
        ),
        SizedBox(height: 10),
        Obx(() => Wrap(
          spacing: 8,
          children: controller.searchUsers('').map((user) =>
              ActionChip(
                label: Text(user.name),
                onPressed: () => controller.addSelectedUser(user),
              )
          ).toList(),
        )),
        SizedBox(height: 10),
        Obx(() => Wrap(
          spacing: 8,
          children: controller.selectedUsers.map((user) =>
              Chip(
                label: Text(user.name),
                deleteIcon: Icon(Icons.close),
                onDeleted: () => controller.removeSelectedUser(user),
              )
          ).toList(),
        )),
      ],
    );
  }
}

