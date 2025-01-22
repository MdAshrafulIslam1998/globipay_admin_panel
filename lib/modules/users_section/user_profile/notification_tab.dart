/**
 * Created by Abdullah on 15/12/24.
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/entity/response/notification/notification_response_item_entity.dart';
import 'package:globipay_admin_panel/modules/users_section/user_profile/notification_model.dart';
import 'package:globipay_admin_panel/modules/users_section/user_profile/profile_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';


class NotificationsTab extends StatelessWidget {
  ProfileController controller;
  NotificationsTab(this.controller);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(),
        Expanded(
          child: Obx(() => ListView.builder(
                controller: controller.notificationScrollController,
                itemCount: controller.notifications.length +
                    (controller.isNotificationLoading.value ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < controller.notifications.length) {
                    final notification = controller.notifications[index];
                    return _buildNotificationCard(notification);
                  } else {
                    return _buildLoadingIndicator();
                  }
                },
              )),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
          decoration: InputDecoration(
            hintText: 'Search Notifications',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onChanged: (value) {}),
    );
  }

  Widget _buildNotificationCard(NotificationResponseItemEntity notification) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey.withOpacity(0.1),
          child: Icon(Icons.notifications_outlined, color: Colors.grey, size: 20),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              notification.title ?? "",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              notification.details ?? "",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w300,
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              notification.createdAt.toString(),
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
        trailing: Icon(
          Icons.circle,
          color: Colors.blue.shade200,
          size: 10,
        ),
      ),
    );
  }

  Widget _getNotificationIcon(String content) {
    final IconData icon;
    final Color color;

    if (content.contains('review')) {
      icon = Icons.reviews_outlined;
      color = Colors.orange;
    } else if (content.contains('message')) {
      icon = Icons.message_outlined;
      color = Colors.green;
    } else if (content.contains('security')) {
      icon = Icons.security_outlined;
      color = Colors.red;
    } else if (content.contains('transaction')) {
      icon = Icons.payment_outlined;
      color = Colors.blue;
    } else {
      icon = Icons.notifications_outlined;
      color = Colors.grey;
    }

    return CircleAvatar(
      backgroundColor: color.withOpacity(0.1),
      child: Icon(icon, color: color, size: 20),
    );
  }

  Widget _buildLoadingIndicator() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListTile(
        leading: CircleAvatar(),
        title: Container(
          color: Colors.white,
          height: 10,
          margin: EdgeInsets.only(bottom: 5),
        ),
        subtitle: Container(
          color: Colors.white,
          height: 10,
        ),
      ),
    );
  }
}
