// category_screen_builder.dart
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:globipay_admin_panel/core/base/base_view_state.dart';
import 'package:globipay_admin_panel/modules/amount_section/create_category/controller/create_category_controller.dart';

class CreateCategoryScreenBuilder extends StatefulWidget {
  const CreateCategoryScreenBuilder({Key? key}) : super(key: key);

  @override
  State<CreateCategoryScreenBuilder> createState() => _CategoryScreenBuilderState();
}

class _CategoryScreenBuilderState extends BaseViewState<CreateCategoryScreenBuilder, CreateCategoryController> {
  @override
  void initState() {
    controller.onInit();
    super.initState();
  }

  @override
  PreferredSizeWidget? appBar() {
    return AppBar(title: Text('Category Management'));
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCreateCategoryCard(),
          const SizedBox(height: 20),
          _buildCategoryListCard(),
        ],
      ),
    );
  }

  Widget _buildCreateCategoryCard() {
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
            Text(
              'Create New Brand',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.categoryNameController,
                    decoration: InputDecoration(
                      hintText: 'Brand Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: controller.pickImage,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                  child: const Text('Choose File'),
                ),
                const SizedBox(width: 16),
                Obx(() => Text(
                  controller.selectedImagePath.value.isEmpty
                      ? 'No file chosen'
                      : 'File selected',
                  style: TextStyle(color: Colors.grey[600]),
                )),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: controller.createCategory,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                  child: const Text('Create New Brand'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryListCard() {
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
            Text(
              'Brand List',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            Obx(() => controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : _buildCategoryTable()),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTable() {
    return Table(
      columnWidths: const {
        0: FixedColumnWidth(80), // Logo column
        1: FlexColumnWidth(1), // Name column
        2: FixedColumnWidth(80), // Delete column
      },
      border: TableBorder.all(
        color: Colors.grey.shade300,
        width: 1,
      ),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
          ),
          children: [
            _buildTableHeader('Brand Logo'),
            _buildTableHeader('Brand Name'),
            _buildTableHeader('Delete'),
          ],
        ),
        ...controller.categories.map((category) => TableRow(
          children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  category.image,
                  height: 40,
                  width: 40,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(category.name),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => controller.deleteCategory(category.id),
              ),
            ),
          ],
        )).toList(),
      ],
    );
  }

  Widget _buildTableHeader(String text) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}