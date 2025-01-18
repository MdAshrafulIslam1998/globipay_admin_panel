import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/utils/extensions.dart';
import 'package:globipay_admin_panel/entity/response/user_profile/user_profile_details_response.dart';
import 'package:globipay_admin_panel/modules/users_section/user_profile/profile_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileDetailsInfoScreen extends StatelessWidget {
  ProfileController controller;
  ProfileDetailsInfoScreen(this.controller);

  final List<String> statusOptions = [
    'VERIFIED',
    'PENDING',
    'REJECTED',
    'BLOCKED',
    'DELETED',
    'INITIATED'
  ];

  // Helper method to check if a string is empty or null
  bool _hasData(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  // Helper method to create info fields only if they have data
  List<Widget> _buildDynamicInfoFields(UserProfileData? profile) {
    final fields = [
      if (_hasData(profile?.userName))
        _buildInfoCard(
          Icons.person_outline,
          "Full Name",
          profile?.userName ?? "",
        ),
      if (_hasData(profile?.email))
        _buildInfoCard(
          Icons.mail_outline,
          "Email",
          profile?.email ?? "",
        ),
      if (_hasData(profile?.dob))
        _buildInfoCard(
          Icons.calendar_today_outlined,
          "Date of Birth",
          profile?.dob ?? "",
        ),
      if (_hasData(profile?.gender))
        _buildInfoCard(
          Icons.wc,
          "Gender",
          profile?.gender ?? "",
        ),
      if (_hasData(profile?.phone))
        _buildInfoCard(
          Icons.phone_outlined,
          "Phone",
          profile?.phone ?? "",
        ),
      if (_hasData(profile?.address))
        _buildInfoCard(
          Icons.location_on_outlined,
          "Address",
          profile?.address ?? "",
        ),
      if (_hasData(profile?.city))
        _buildInfoCard(
          Icons.location_city_outlined,
          "City",
          profile?.city ?? "",
        ),
      if (_hasData(profile?.state))
        _buildInfoCard(
          Icons.public_outlined,
          "State",
          profile?.state ?? "",
        ),
      if (_hasData(profile?.zipCode))
        _buildInfoCard(
          Icons.location_on_outlined,
          "Zip Code",
          profile?.zipCode ?? "",
        ),
    ];

    // Split fields into two columns
    final midPoint = (fields.length / 2).ceil();
    return fields;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Obx(() {
            if (controller.profileData.value == null) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF3B82F6),
                ),
              );
            }

            var profile = controller.profileData.value;
            final infoFields = _buildDynamicInfoFields(profile);
            final midPoint = (infoFields.length / 2).ceil();

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 2,
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_hasData(profile?.userCode))
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            border: Border(
                              bottom: BorderSide(
                                color:
                                const Color(0xFFD97706).withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Center(
                            child: SelectableText(
                              "Profile for ${profile?.userCode ?? ""}",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFD97706),
                              ),
                              toolbarOptions: const ToolbarOptions(
                                copy: true, // Enable the copy option
                                selectAll: true, // Enable the select-all option
                              ),
                              showCursor: true, // Optional: Shows a cursor when text is selected
                              cursorColor: Colors.orange, // Optional: Set the cursor color
                              cursorWidth: 2.0, // Optional: Adjust cursor width
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (infoFields.isNotEmpty) ...[
                              _buildHeaderSectionTitle("Personal Information"),
                              const SizedBox(height: 24),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: infoFields
                                          .sublist(0, midPoint)
                                          .map((field) => Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            bottom: 12),
                                        child: field,
                                      ))
                                          .toList(),
                                    ),
                                  ),
                                  const SizedBox(width: 24),
                                  Expanded(
                                    child: Column(
                                      children: infoFields
                                          .sublist(midPoint)
                                          .map((field) => Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            bottom: 12),
                                        child: field,
                                      ))
                                          .toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ],

                            if (_hasData(profile?.status)) ...[
                              const SizedBox(height: 24),
                              _buildInfoCard(
                                Icons.verified_user_outlined,
                                "Current Status",
                                profile?.status ?? "",
                              ),
                            ],

                            // Only show documents section if any document exists
                            if (_hasData(profile?.selfiePath) ||
                                _hasData(profile?.frontIdPath) ||
                                _hasData(profile?.backIdPath)) ...[
                              const SizedBox(height: 32),
                              _buildVerificationSectionTitle("Verification Documents"),
                              const SizedBox(height: 24),
                              Row(
                                children: [
                                  if (_hasData(profile?.selfiePath))
                                    Expanded(
                                      child: _buildDocumentCard(
                                        (profile?.selfiePath ?? "")
                                            .includeBaseUrl(),
                                        "Profile Picture",
                                      ),
                                    ),
                                  if (_hasData(profile?.frontIdPath)) ...[
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: _buildDocumentCard(
                                        (profile?.frontIdPath ?? "")
                                            .includeBaseUrl(),
                                        "ID Card Front",
                                      ),
                                    ),
                                  ],
                                  if (_hasData(profile?.backIdPath)) ...[
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: _buildDocumentCard(
                                        (profile?.backIdPath ?? "")
                                            .includeBaseUrl(),
                                        "ID Card Back",
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  PreferredSizeWidget? appBar() {
    return AppBar(
      title: Text(
        'Pending Profile',
      ),
      backgroundColor: const Color(0xFFF7F2FA),
    );
  }

  Widget _buildHeaderSectionTitle(String title) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E293B),
          ),
        ),
        Spacer(),
        Container(
          width: 200,
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFE2E8F0),
              width: 1,
            ),
          ),
          child: Obx(() => DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: controller.selectedStatus.value,
              isExpanded: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              borderRadius: BorderRadius.circular(12),
              items: statusOptions.map((String status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(
                    status,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  controller.onStatusChanged(newValue);
                  print('Status changed to: $newValue'); // Debug print
                }
              },
            ),
          )),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: () {
            controller.updateStatus();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3B82F6),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: Text(
            'Update Status',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildVerificationSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF1E293B),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: const Color(0xFF3B82F6),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentCard(String url, String label) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF64748B),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
            child: Image.network(
              url,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 180,
                color: const Color(0xFFE2E8F0),
                child: Icon(
                  Icons.broken_image,
                  size: 48,
                  color: const Color(0xFF64748B),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusUpdateSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

      ],
    );
  }
}
