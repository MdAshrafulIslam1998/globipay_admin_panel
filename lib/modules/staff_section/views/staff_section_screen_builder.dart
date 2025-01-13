// staff_section_screen_builder.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_view.dart';
import 'package:globipay_admin_panel/core/base/base_view_state.dart';
import 'package:globipay_admin_panel/core/constants/enum/role_name.dart';
import 'package:globipay_admin_panel/core/data/model/common_data_entity.dart';
import 'package:globipay_admin_panel/entity/response/staff/staff_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/staff/staff_response_item_entity.dart';
import 'package:globipay_admin_panel/modules/staff_section/controller/staff_section_controller.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:globipay_admin_panel/router/route_path.dart';
import 'package:google_fonts/google_fonts.dart';


class StaffSectionScreenBuilder extends StatefulWidget {
  const StaffSectionScreenBuilder({super.key});

  @override
  State<StaffSectionScreenBuilder> createState() => _StaffSectionScreenBuilderState();
}

class _StaffSectionScreenBuilderState extends BaseViewState<StaffSectionScreenBuilder,StaffSectionController> {

  @override
  void initState() {
    controller.onInit();
    super.initState();
  }
  @override
  Widget body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Role Management'),
      ),
      body: Container(
        color: Colors.grey[50],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  roleHeader(context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Roles Overview',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      Obx(() => Text(
                        'Total Roles: ${controller.roles.length}',
                        style: Theme.of(context).textTheme.titleMedium,
                      )),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Obx(() => ListView.builder(
                      itemCount: controller.staffList.length,
                      itemBuilder: (context, index) {
                        return _buildStaffListItem(controller.staffList[index]);
                      },
                    )),
                  ),
                ],
              ),
            ),
          ),
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
            staff.name![0].toUpperCase(),
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
            /*const SizedBox(width: 10),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () => controller.deleteRole(staff),
              tooltip: 'Delete Role',
            ),*/
          ],
        ),
      ),
    );
  }

  Color _getRoleColor(String role) {
    if (role == RoleName.ADMIN.title) {
      return Colors.deepPurple;
      return Colors.blue;
    } else if (role == RoleName.MODERATOR.title) {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }

  Widget roleHeader(BuildContext context) {
    return  Form(
      key: controller.staffFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
              if (value!.isEmpty) {
                return 'Name is required';
              }
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
              if (value!.isEmpty) {
                return 'Email is required';
              } else if (!GetUtils.isEmail(value)) {
                return 'Invalid email address';
              }
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
                    controller.isPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off
                ),
                onPressed: controller.togglePasswordVisibility,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Password is required';
              } else if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
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
              if (value != null) {
                controller.selectedRole.value = value;
              }
            },
            validator: (value) {
              if (value == null) {
                return 'Role is required';
              }
              return null;
            },
          )),
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed: controller.createRole,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Create Staff',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      ),
    );
  }
}
