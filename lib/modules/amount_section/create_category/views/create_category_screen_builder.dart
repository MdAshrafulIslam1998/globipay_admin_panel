// category_screen_builder.dart
import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:globipay_admin_panel/router/app_routes.dart';

class CreateCategoryScreenBuilder extends StatefulWidget {
  const CreateCategoryScreenBuilder({Key? key}) : super(key: key);

  @override
  State<CreateCategoryScreenBuilder> createState() =>
      _CategoryScreenBuilderState();
}

class _CategoryScreenBuilderState extends BaseViewState<
    CreateCategoryScreenBuilder, CreateCategoryController> {
  late Color currentSelectedColor;

  @override
  void initState() {
    currentSelectedColor = Colors.blue;
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
      padding: EdgeInsets.all(16.0),
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
        padding: EdgeInsets.all(16.0),
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
                  child: Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(left: 16),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: currentSelectedColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.color_lens, color: Colors.white),
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
            child:ColorPicker(
                hexInputBar: true,
                onColorChanged: (Color color) {
                  controller.categoryColor = color;
                  setState(() {
                    currentSelectedColor = color;
                  });
                },
                showLabel: true,
                // Display the color code
                pickerAreaHeightPercent: 0.8,
              pickerColor: Colors.blue, // Adjust the picker size
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                AppRoutes.pop();
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
        2: FlexColumnWidth(1), // Name column
        3: FixedColumnWidth(80), // Name column
        4: FixedColumnWidth(80), // Name column
        5: FixedColumnWidth(80), // Delete column
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
            _buildTableHeader('Opening Message'),
            _buildTableHeader('Message Status'),
            _buildTableHeader('Edit'),
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
                        child: CachedNetworkImage(
                          imageUrl : category.image?.includeBaseUrl() ?? '',
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
                        child: Text(
                            category.name ?? '',
                            textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text(category.message ?? 'This is a opening  message',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text((category.message_status ?? false ) ? 'Running' : 'Inactive',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.green),
                        onPressed: () =>
                            controller.editCategory(category),
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
