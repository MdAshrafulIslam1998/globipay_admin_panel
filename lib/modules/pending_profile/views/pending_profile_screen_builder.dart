import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/modules/pending_profile/controller/pending_profile_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class PendingProfileScreenBuilder extends StatelessWidget {
  final PendingProfileController controller = Get.put(PendingProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Profile Documents",
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 2,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Obx(() {
          if (controller.profileData.value == null) {
            return Center(child: CircularProgressIndicator());
          }

          var profile = controller.profileData.value!;
          return Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("Profile Information"),
                  const SizedBox(height: 20),
                  
                  // Profile Information in two columns of 3 items each, left-aligned
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoTile("Full Name", profile.fullName),
                            _buildInfoTile("Gender", profile.gender),
                            _buildInfoTile("Email", profile.email),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoTile("Phone", profile.phone),
                            _buildInfoTile("Date of Birth", profile.dob),
                            _buildInfoTile("Address", profile.address),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const Divider(thickness: 1, height: 40),
                  _buildSectionTitle("Profile Documents"),
                  const SizedBox(height: 20),
                  
                  // Profile Document Images, larger and rectangular
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildImageTile(profile.selfiePath, "Profile Picture"),
                      _buildImageTile(profile.frontIdPath, "NID Front"),
                      _buildImageTile(profile.backIdPath, "NID Back"),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Compact Action Buttons aligned to the left side
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildActionButton("Approve", Colors.green, controller.onApprove),
                      const SizedBox(width: 8),
                      _buildActionButton("Pending", Colors.amber[700]!, controller.onPending),
                      const SizedBox(width: 8),
                      _buildActionButton("Delete", Colors.red, controller.onRemove),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.blueAccent),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey[600])),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              value,
              style: GoogleFonts.poppins(fontSize: 15, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageTile(String url, String label) {
    return Column(
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey[700])),
        const SizedBox(height: 12),
        Container(
          width: 140,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              url,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image, color: Colors.grey, size: 50),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(String label, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 3,
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }
}
