// category_screen_builder.dart
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:globipay_admin_panel/core/base/base_view_state.dart';
import 'package:globipay_admin_panel/core/theme/app_colors.dart';
import 'package:globipay_admin_panel/core/utils/extensions.dart';
import 'package:globipay_admin_panel/core/widgets/text_filed/input_field.dart';
import 'package:globipay_admin_panel/core/widgets/text_filed/input_regex.dart';
import 'package:globipay_admin_panel/core/widgets/web_image/web_image.dart';
import 'package:globipay_admin_panel/modules/amount_section/create_category/controller/create_category_controller.dart';

class CreateCategoryScreenBuilder extends StatefulWidget {
  const CreateCategoryScreenBuilder({Key? key}) : super(key: key);

  @override
  State<CreateCategoryScreenBuilder> createState() =>
      _CategoryScreenBuilderState();
}

class _CategoryScreenBuilderState extends BaseViewState<
    CreateCategoryScreenBuilder, CreateCategoryController> {
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
      padding:  EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WebImagePicker(
            height: 150,
            width: 100,
            hint: 'Select Category Image',
            onImageSelected: (bytes, file) {
              controller.selectedImageBytes = bytes;
            },
          ),
          _buildCreateCategoryCard(),
          const SizedBox(height: 20),
          Expanded(
              child: SingleChildScrollView(child: _buildCategoryListCard())),
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
        padding:  EdgeInsets.all(16.0),
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
                  child: InputField(
                    controller: controller.categoryNameController,
                    hintText: 'Brand Name',
                    regex: InputRegex.NOT_EMPTY,
                  ),
                ),
                InkWell(
                  onTap: () {
                    _openColorPicker(context);
                  },
                  child: Obx(
                    () => Container(
                      padding:  EdgeInsets.all(8),
                      margin:  EdgeInsets.only(left: 16),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: controller.currentColor.value,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child:  Icon(Icons.color_lens, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: controller.createCategory,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                  ),
                  child: const Text('Create New Brand',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _openColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: Obx(
              () => ColorPicker(
                pickerColor: controller.currentColor.value,
                onColorChanged: (Color color) {
                  controller.currentColor.value = color;
                },
                showLabel: true, // Display the color code
                pickerAreaHeightPercent: 0.8, // Adjust the picker size
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                controller.currentColor.refresh();
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
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
            Obx(() => _buildCategoryTable()),
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
        ...controller.categories
            .map((category) => TableRow(
                  children: [
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          category.image?.includeBaseUrl() ?? '',
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
                        child: Text(category.name ?? ''),
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () =>
                            controller.deleteCategory(category.id.toString()),
                      ),
                    ),
                  ],
                ))
            .toList(),
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
