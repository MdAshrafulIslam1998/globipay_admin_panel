import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/modules/media_section/automated_reply/controller/automated_reply_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class AutomatedReplyScreenBuilder extends StatelessWidget {
  final AutomatedReplyController controller;

  AutomatedReplyScreenBuilder({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final categories = controller.categories;

      

      return categories.isEmpty
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 1, // Makes each grid item square
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return AutomatedReplyCard(
                  categoryName: category.name,
                  imageUrl: category.image,
                  onSave: (message) {
                    // Print the saved message and category name to the console
                    print('Saved message for ${category.name}: $message');
                  },
                );
              },
            );
    });
  }
}

class AutomatedReplyCard extends StatefulWidget {
  final String categoryName;
  final String imageUrl;
  final Function(String) onSave;

  AutomatedReplyCard({
    required this.categoryName,
    required this.imageUrl,
    required this.onSave,
  });

  @override
  _AutomatedReplyCardState createState() => _AutomatedReplyCardState();
}

class _AutomatedReplyCardState extends State<AutomatedReplyCard> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Category Image
            Image.network(
              widget.imageUrl,
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),

            // Category Name
            Text(
              widget.categoryName,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),

            // Message Input Box
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _messageController,
                  maxLines: null, // Allows wrapping text
                  decoration: InputDecoration(
                    hintText: 'Enter automated message',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.onSave(_messageController.text);
                  _messageController.clear(); // Clear the input after saving
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Save',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
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
