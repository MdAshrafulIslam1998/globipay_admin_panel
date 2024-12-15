// staff_section_screen_builder.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/modules/staff_section/controller/staff_section_controller.dart';
import 'package:google_fonts/google_fonts.dart';


class StaffSectionScreenBuilder extends StatelessWidget {
  final StaffSectionController controller = Get.put(StaffSectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Staff Section",
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add Staff Form
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Staff',
                      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: controller.nameController,
                      decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: controller.emailController,
                      decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: controller.passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => DropdownButtonFormField<String>(
                        value: controller.selectedRole.value.isEmpty ? null : controller.selectedRole.value,
                        items: controller.roles.map((role) {
                          return DropdownMenuItem<String>(
                            value: role['id'].toString(),
                            child: Text(role['role_name']),
                          );
                        }).toList(),
                        onChanged: (value) => controller.selectedRole.value = value ?? '',
                        decoration: const InputDecoration(labelText: 'Role', border: OutlineInputBorder()),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: controller.addStaff,
                      child: Text('Add Staff', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24)),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Staff List Table
            Expanded(
              child: Obx(
                () => controller.isLoadingStaff.value
                    ? const Center(child: CircularProgressIndicator())
                    : Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Staff List',
                                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 16),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: controller.staffList.length,
                                  itemBuilder: (context, index) {
                                    final staff = controller.staffList[index];
                                    return ListTile(
                                      title: Text(staff['name']),
                                      subtitle: Text('${staff['email']} \u2022 ${staff['role_name']}'),
                                      trailing: Text(
                                        staff['status'],
                                        style: TextStyle(
                                          color: staff['status'] == 'ACTIVE' ? Colors.green : Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
