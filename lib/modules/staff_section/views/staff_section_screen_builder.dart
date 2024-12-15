import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_view.dart';
import 'package:globipay_admin_panel/entity/response/fetch_staff/all_staff_item_entity.dart';
import 'package:globipay_admin_panel/modules/staff_section/controller/staff_section_controller.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:globipay_admin_panel/router/route_path.dart';

class StaffSectionScreenBuilder extends BaseView<StaffSectionController> {
  StaffSectionScreenBuilder() {
    controller.onInit();
  }

  @override
  Widget body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Management', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          ElevatedButton.icon(
            icon: Icon(Icons.add, color: Colors.white),
            label: Text('Add Staff', style: TextStyle(color: Colors.white)),
            onPressed: () {
              AppRoutes.pushNamed(RoutePath.staffSection).then((value) {
                controller.fetchStaff();
              });
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
            child: Obx(() => _buildStaffList()),
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
          hintText: 'Search staff...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onChanged: (value) => controller.searchQuery.value = value,
      ),
    );
  }

  Widget _buildStaffList() {
    final filteredStaff = controller.filteredStaffList;

    return filteredStaff.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.group_outlined, size: 100, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No Staff Found',
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: filteredStaff.length,
            itemBuilder: (context, index) {
              final staff = filteredStaff[index];
              return _buildStaffCard(staff);
            },
          );
  }

  Widget _buildStaffCard(AllStaffItemEntity staff) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(staff.name ?? "", style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              staff.email ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8),
            Text(
              "Role: ${staff.roleName ?? ''}",
              style: TextStyle(color: Colors.blue.shade800, fontSize: 12),
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () => controller.removeStaff(staff.staffId ?? 0),
          tooltip: 'Remove Staff',
        ),
      ),
    );
  }
}
