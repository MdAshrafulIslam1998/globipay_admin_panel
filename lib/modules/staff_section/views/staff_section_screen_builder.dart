import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_view.dart';
import 'package:globipay_admin_panel/core/base/base_view_state.dart';
import 'package:globipay_admin_panel/core/constants/enum/role_name.dart';
import 'package:globipay_admin_panel/core/data/model/common_data_entity.dart';
import 'package:globipay_admin_panel/core/theme/app_colors.dart';
import 'package:globipay_admin_panel/entity/response/staff/staff_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/staff/staff_response_item_entity.dart';
import 'package:globipay_admin_panel/modules/staff_section/controller/staff_section_controller.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:globipay_admin_panel/router/route_path.dart';
import 'package:globipay_admin_panel/core/theme/app_colors.dart';

class StaffSectionScreenBuilder extends StatefulWidget {
  const StaffSectionScreenBuilder({super.key});
  @override
  State<StaffSectionScreenBuilder> createState() => _StaffSectionScreenBuilderState();
}

class _StaffSectionScreenBuilderState extends BaseViewState<StaffSectionScreenBuilder, StaffSectionController> {
  @override
  void initState() {
    controller.onInit();
    super.initState();
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      color: AppColors.projectWhite,
      child: Card(
        color: AppColors.projectWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: const BoxDecoration(
                color: AppColors.projectBlue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Text(
                'Role Management',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.projectFontBlue,
                ),
              ),
            ),
            
            // Form Section
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Create Staff Form
                    Form(
                      key: controller.staffFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: controller.nameController,
                            decoration: InputDecoration(
                              labelText: 'Full Name',
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) return 'Name is required';
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: controller.emailController,
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                              prefixIcon: const Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) return 'Email is required';
                              if (!GetUtils.isEmail(value)) return 'Invalid email address';
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          Obx(() => TextFormField(
                            controller: controller.passwordController,
                            obscureText: !controller.isPasswordVisible.value,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.isPasswordVisible.value ? Icons.visibility : Icons.visibility_off
                                ),
                                onPressed: controller.togglePasswordVisibility,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) return 'Password is required';
                              if (value.length < 6) return 'Password must be at least 6 characters';
                              return null;
                            },
                          )),
                          const SizedBox(height: 15),
                          Obx(() => DropdownButtonFormField<CommonDataEntity>(
                            value: controller.selectedRole.value,
                            decoration: InputDecoration(
                              labelText: 'User Role',
                              prefixIcon: const Icon(Icons.work),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            items: controller.roles
                                .map((role) => DropdownMenuItem(
                                      value: role,
                                      child: Text(role.key ?? ""),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              if (value != null) controller.selectedRole.value = value;
                            },
                            validator: (value) {
                              if (value == null) return 'Role is required';
                              return null;
                            },
                          )),
                          const SizedBox(height: 20),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              width: 450, // Fixed width for the button
                              height: 40,  // Fixed height for the button
                              child: ElevatedButton(
                                onPressed: controller.createRole,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.projectButtonBlue2,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Create Staff',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Staff List Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Staff Overview',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.projectButtonBlue2,
                          ),
                        ),
                        Obx(() => Text(
                          'Total Staff: ${controller.staffList.length}',
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Obx(() => ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.staffList.length,
                      itemBuilder: (context, index) {
                        return _buildStaffListItem(controller.staffList[index]);
                      },
                    )),
                  ],
                ),
              ),
            ),
            
            // Footer
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: const BoxDecoration(
                color: Color(0xFFF4F7FF),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(() => Text(
                    'Active Staff Members: ${controller.staffList.length}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C3E50),
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStaffListItem(StaffResponseItemEntity staff) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getRoleColor(staff.roleName ?? ""),
          child: Text(
            staff.name?[0].toUpperCase() ?? "",
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          staff.name ?? "",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(staff.email ?? ""),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Chip(
              label: Text(
                staff.roleName ?? "",
                style: TextStyle(
                  color: _getRoleColor(staff.roleName ?? ""),
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: _getRoleColor(staff.roleName ?? "").withOpacity(0.1),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case 'ADMIN':
        return Colors.deepPurple;
      case 'MODERATOR':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}