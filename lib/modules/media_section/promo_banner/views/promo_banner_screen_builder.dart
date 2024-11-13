import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/modules/media_section/promo_banner/controller/promo_banner_controller.dart';

class PromoBannerScreenBuilder extends StatelessWidget {
  final PromoBannerController controller = Get.put(PromoBannerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Promotional Banner"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner Title
                Text(
                  'Social Media Banner Title',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: controller.titleController,
                  decoration: InputDecoration(
                    hintText: 'Enter banner title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),

                // Banner Body
                Text(
                  'Banner Body',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: controller.bodyController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Enter banner content',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),

                // Banner Image Upload
                Text(
                  'Choose Banner Image',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: controller.pickImage,
                  child: Text("Choose File"),
                ),
                Obx(() => Text(
                  controller.imageFileName.value.isNotEmpty
                      ? controller.imageFileName.value
                      : 'No file chosen',
                )),
                const SizedBox(height: 24),

                // Start/Stop Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: controller.startShowing,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: Text("Start Showing"),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: controller.stopShowing,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: Text("Stop Showing"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Current Status
                Obx(() => Text(
                  'Current Banner Status: ${controller.isBannerShowing.value ? "Showing" : "Not Showing"}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: controller.isBannerShowing.value ? Colors.green : Colors.red,
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
