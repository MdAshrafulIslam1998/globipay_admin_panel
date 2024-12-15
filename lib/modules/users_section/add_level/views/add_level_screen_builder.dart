import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_view.dart';
import 'package:globipay_admin_panel/modules/users_section/add_level/controller/add_level_controller.dart';
import 'package:globipay_admin_panel/modules/users_section/add_level/controller/level_model.dart';
import 'package:intl/intl.dart';

class AddLevelScreenBuilder extends BaseView<AddLevelController> {
  AddLevelScreenBuilder({Key? key}) : super(key: key) {
    controller.onInit();
  }

  @override
  Widget body(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFFE0FFF6),
      brightness: Brightness.light,
    );

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Level Management',
          style: TextStyle(
            color: Color(0xB5080007),
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Color(0xFFE5F7E3),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              children: [
                // Existing Levels Column
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    margin: const EdgeInsets.only(right: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Existing Levels',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: Obx(() {
                              if (controller.levels.isEmpty) {
                                return Center(
                                  child: Text(
                                    'No levels found',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                );
                              }
                              return ListView.separated(
                                itemCount: controller.levels.length,
                                separatorBuilder: (context, index) => const SizedBox(height: 8),
                                itemBuilder: (context, index) {
                                  final level = controller.levels[index];
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: colorScheme.surface,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.grey.shade200,
                                      ),
                                    ),
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      title: Text(
                                        'Level ${level.levelName}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: colorScheme.primary,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 4),
                                          Text(
                                            'Value: ${level.levelValue}',
                                            style: TextStyle(
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                          Text(
                                            'Range: ${level.minThresh} - ${level.maxThresh}',
                                            style: TextStyle(
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                          Text(
                                            'Created: ${DateFormat('dd MMM yyyy HH:mm').format(level.date ?? DateTime.now())}',
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.edit, color: Colors.grey),
                                        onPressed: () {
                                          _showEditDialog(context, level);
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Add New Level Column
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: controller.formKey,
                        child: ListView(
                          children: [
                            Text(
                              'Add New Level',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildTextFormField(
                              context,
                              controller: controller.levelNameController,
                              labelText: 'Level Name',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter level name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            _buildTextFormField(
                              context,
                              controller: controller.levelValueController,
                              labelText: 'Level Value',
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter level value';
                                }
                                if (int.tryParse(value) == null) {
                                  return 'Please enter a valid number';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            _buildTextFormField(
                              context,
                              controller: controller.minThreshController,
                              labelText: 'Minimum Threshold',
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter minimum threshold';
                                }
                                if (double.tryParse(value) == null) {
                                  return 'Please enter a valid number';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            _buildTextFormField(
                              context,
                              controller: controller.maxThreshController,
                              labelText: 'Maximum Threshold',
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter maximum threshold';
                                }
                                if (double.tryParse(value) == null) {
                                  return 'Please enter a valid number';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: controller.addLevel,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF79A375),
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 2,
                              ),
                              child: const Text(
                                'Add Level',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, LevelModel level) {
    final TextEditingController nameController =
        TextEditingController(text: level.levelName);
    final TextEditingController valueController =
        TextEditingController(text: (level.levelValue ?? "").toString());
    final TextEditingController minThreshController =
        TextEditingController(text: (level.minThresh ?? "").toString());
    final TextEditingController maxThreshController =
        TextEditingController(text: (level.maxThresh ?? "").toString());

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Level"),
          content: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextFormField(context,
                    controller: nameController, labelText: "Level Name"),
                const SizedBox(height: 10),
                _buildTextFormField(context,
                    controller: valueController,
                    labelText: "Level Value",
                    keyboardType: TextInputType.number),
                const SizedBox(height: 10),
                _buildTextFormField(context,
                    controller: minThreshController,
                    labelText: "Minimum Threshold",
                    keyboardType: TextInputType.number),
                const SizedBox(height: 10),
                _buildTextFormField(context,
                    controller: maxThreshController,
                    labelText: "Maximum Threshold",
                    keyboardType: TextInputType.number),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                // Simulated API Call
                print({
                  "level_name": nameController.text,
                  "level_value": int.parse(valueController.text),
                  "min_thresh": double.parse(minThreshController.text),
                  "max_thresh": double.parse(maxThreshController.text),
                });

                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextFormField(
    BuildContext context, {
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: const Color(0xFF3B82F6),
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
      ),
      validator: validator,
    );
  }
}
