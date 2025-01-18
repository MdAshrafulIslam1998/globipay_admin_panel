/**
 * Created by Abdullah on 15/12/24.
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_view.dart';
import 'package:globipay_admin_panel/entity/response/user_profile/user_profile_details_response.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_item_entity.dart';
import 'package:globipay_admin_panel/modules/users_section/user_profile/profile_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/user_profile/profile_details_info_screen.dart';
import 'package:globipay_admin_panel/modules/users_section/user_profile/transaction_tab.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/user_profile/activity_log_model.dart';
import 'package:globipay_admin_panel/modules/users_section/user_profile/transaction_model.dart';
import 'package:globipay_admin_panel/modules/users_section/user_profile/notification_model.dart';

import 'activity_log_tab.dart';
import 'notification_tab.dart';

class ProfileScreen extends BaseView<ProfileController> {

  final UserResponseItemEntity? user;
  ProfileScreen({ this.user}){
    controller.onInit();
    controller.fetchInitialData(user);

  }

  @override
  Widget body(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'User Profile',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            tabs: [
              Tab(text: 'Profile'),
              Tab(text: 'Transactions'),
              Tab(text: 'Activity Log'),
              Tab(text: 'Notifications'),
            ],
          ),
        ),
        body: Obx(() {
          if (controller.profileData.value == null) {
            return _buildLoadingScreen();
          }

          return TabBarView(
            children: [
              ProfileDetailsInfoScreen(controller),
              TransactionsTab(controller),
              ActivityLogTab(controller),
              NotificationsTab(controller),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(radius: 50),
            SizedBox(height: 10),
            Container(
              width: 200,
              height: 20,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Container(
              width: 150,
              height: 20,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(UserProfileData profile) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
              'https://via.placeholder.com/150',
            ),
          ),
          SizedBox(height: 10),
          Text(
            profile?.email??"",
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            profile?.email??"",
            style: GoogleFonts.poppins(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalDetails(UserProfileData profile) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Email', profile?.email??''),
            Divider(),
            // Add more personal details here
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            // Implement edit profile
          },
          icon: Icon(Icons.edit),
          label: Text('Edit Profile'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            // Implement account settings
          },
          icon: Icon(Icons.settings),
          label: Text('Settings'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}