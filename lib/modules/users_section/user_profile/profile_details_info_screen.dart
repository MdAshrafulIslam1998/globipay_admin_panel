import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/modules/users_section/user_profile/profile_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
/**
 * Created by Abdullah on 15/12/24.
 */

class ProfileDetailsInfoScreen extends StatelessWidget {

  ProfileController controller;
  ProfileDetailsInfoScreen(this.controller);

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final screenSize = MediaQuery.of(context).size;

    return Container(
      child: Center(
        // Center the content
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 1200, // Maximum width for the content
            maxHeight: screenSize.height, // Use full screen height
          ),
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

              var profile = controller.profileData.value!;
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
                        // Status Banner
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            border: Border(
                              bottom: BorderSide(
                                color: const Color(0xFFD97706).withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Pending Review",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFD97706),
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSectionTitle("Personal Information"),
                              const SizedBox(height: 24),

                              // Profile Information Grid - More compact
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        _buildInfoCard(
                                          Icons.person_outline,
                                          "Full Name",
                                          profile.fullName,
                                        ),
                                        const SizedBox(height: 12),
                                        _buildInfoCard(
                                          Icons.mail_outline,
                                          "Email",
                                          profile.email,
                                        ),
                                        const SizedBox(height: 12),
                                        _buildInfoCard(
                                          Icons.calendar_today_outlined,
                                          "Date of Birth",
                                          profile.dob,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 24),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        _buildInfoCard(
                                          Icons.wc,
                                          "Gender",
                                          profile.gender,
                                        ),
                                        const SizedBox(height: 12),
                                        _buildInfoCard(
                                          Icons.phone_outlined,
                                          "Phone",
                                          profile.phone,
                                        ),
                                        const SizedBox(height: 12),
                                        _buildInfoCard(
                                          Icons.location_on_outlined,
                                          "Address",
                                          profile.address,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 32),
                              _buildSectionTitle("Verification Documents"),
                              const SizedBox(height: 24),

                              // Documents Grid - Adjusted for better fit
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildDocumentCard(
                                      profile.selfiePath,
                                      "Profile Picture",
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: _buildDocumentCard(
                                      profile.frontIdPath,
                                      "ID Card Front",
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: _buildDocumentCard(
                                      profile.backIdPath,
                                      "ID Card Back",
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 32),
                              // Compact, Left-aligned Action Buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 120, // Fixed width for buttons
                                    child: _buildActionButton(
                                      "Approve",
                                      const Color(0xFF22C55E),
                                      controller.onApprove,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  SizedBox(
                                    width: 120,
                                    child: _buildActionButton(
                                      "Pending",
                                      const Color(0xFFD97706),
                                      controller.onPending,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  SizedBox(
                                    width: 120,
                                    child: _buildActionButton(
                                      "Delete",
                                      const Color(0xFFEF4444),
                                      controller.onRemove,
                                    ),
                                  ),
                                ],
                              ),
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

  Widget _buildSectionTitle(String title) {
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
              height: 180, // Slightly reduced height
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

  Widget _buildActionButton(String label, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}