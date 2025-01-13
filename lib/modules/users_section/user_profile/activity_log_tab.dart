/// Created by Abdullah on 15/12/24.
library;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/modules/users_section/user_profile/activity_log_model.dart';
import 'package:globipay_admin_panel/modules/users_section/user_profile/profile_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class ActivityLogTab extends StatelessWidget {

  ProfileController controller;
  ActivityLogTab(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(),
        Expanded(
          child: Obx(() => ListView.builder(
            controller: controller.activityScrollController,
            itemCount: controller.activityLogs.length +
                (controller.isActivityLoading.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < controller.activityLogs.length) {
                final activity = controller.activityLogs[index];
                return _buildActivityLogCard(activity);
              } else {
                return _buildLoadingIndicator();
              }
            },
          )),
        ),
        _buildExportButton(),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search Activity Logs',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: (value) {
          // Implement search logic
        },
      ),
    );
  }

  Widget _buildActivityLogCard(ActivityLogModel activity) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: _getActivityIcon(activity.type),
        title: Text(
          activity.type,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        trailing: Text(
          activity.formattedTimestamp,
          style: GoogleFonts.poppins(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _getActivityIcon(String type) {
    final IconData icon;
    final Color color;

    switch (type) {
      case 'Login':
        icon = Icons.login;
        color = Colors.blue;
        break;
      case 'Chat Created':
        icon = Icons.chat;
        color = Colors.green;
        break;
      case 'Profile Pic Changed':
        icon = Icons.camera_alt;
        color = Colors.purple;
        break;
      default:
        icon = Icons.event;
        color = Colors.grey;
    }

    return CircleAvatar(
      backgroundColor: color.withOpacity(0.1),
      child: Icon(icon, color: color),
    );
  }

  Widget _buildLoadingIndicator() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListTile(
        leading: const CircleAvatar(),
        title: Container(color: Colors.white, height: 10),
        subtitle: Container(color: Colors.white, height: 10),
      ),
    );
  }

  Widget _buildExportButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        onPressed: controller.exportActivityLogs,
        icon: const Icon(Icons.download),
        label: const Text('Export Activity Logs'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}