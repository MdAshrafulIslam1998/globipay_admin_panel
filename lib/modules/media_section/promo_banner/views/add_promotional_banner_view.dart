import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:globipay_admin_panel/core/base/base_view_state.dart';
import 'package:globipay_admin_panel/core/theme/app_colors.dart';
import 'package:globipay_admin_panel/core/widgets/web_image/web_image.dart';
import 'package:globipay_admin_panel/modules/media_section/promo_banner/controller/promotional_banner_controller.dart';
import 'package:intl/intl.dart';
import 'dart:html' as web;

class AddPromotionalBannerView extends StatefulWidget {
  @override
  _AddPromotionalBannerViewState createState() => _AddPromotionalBannerViewState();
}

class _AddPromotionalBannerViewState extends BaseViewState<AddPromotionalBannerView,PromotionalBannerController> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _urlController = TextEditingController();

  Uint8List? _imageFile;
  web.File? _imageFileWeb;

  DateTime? _startDate;
  DateTime? _endDate;
  Color _bannerColor = Colors.deepPurple;
  bool _isVisibleToAll = true;
  double _priority = 5.0;


  // Date Range Picker
  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      initialDateRange: _startDate != null && _endDate != null
          ? DateTimeRange(start: _startDate!, end: _endDate!)
          : null,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: _bannerColor,
              primary: _bannerColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }

  // Color Picker Dialog
  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Banner Background Color'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: _bannerColor,
              onColorChanged: (color) {
                setState(() {
                  _bannerColor = color;
                });
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
    );
  }

  // Form Submission
  void _submitBanner() {
    if (!_formKey.currentState!.validate()) return;

    // Comprehensive Validation
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please upload a banner image'),
          backgroundColor: Colors.red[600],
        ),
      );
      return;
    }

    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a date range'),
          backgroundColor: Colors.red[600],
        ),
      );
      return;
    }


    controller.addBanner(
      title: _titleController.text,
      description: _descriptionController.text,
      backgroundColor: _bannerColor,
      imageFile: _imageFileWeb,
      imageFileBytes: _imageFile,
      startDate: _startDate!,
      endDate: _endDate!,
      isVisibleToAll: _isVisibleToAll,
      priority: _priority,
      destinationUrl: _urlController.text,
    );

  }

  @override
  Widget body(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple.shade50,
              Colors.deepPurple.shade100,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.shade100,
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title
                    Text(
                      'Create Promotional Banner',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    SizedBox(height: 32),

                    // Image Upload Section
                    WebImagePicker(
                        onImageSelected: (imageBytes, file) {
                      setState(() {
                        _imageFile = imageBytes;
                        _imageFileWeb = file;
                      });
                    }),
                    SizedBox(height: 24),

                    // Title Input
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Banner Title',
                        prefixIcon: Icon(Icons.title, color: Colors.deepPurple),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) => value!.isEmpty
                          ? 'Please enter a title'
                          : null,
                    ),
                    SizedBox(height: 16),

                    // Description Input
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        prefixIcon: Icon(Icons.description, color: Colors.deepPurple),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) => value!.isEmpty
                          ? 'Please enter a description'
                          : null,
                    ),
                    SizedBox(height: 16),

                    // Date Range Picker
                    ElevatedButton.icon(
                      onPressed: _selectDateRange,
                      icon: Icon(Icons.calendar_month),
                      label: Text(
                        _startDate == null || _endDate == null
                            ? 'Select Date Range'
                            : '${DateFormat('dd MMM').format(_startDate!)} - ${DateFormat('dd MMM yyyy').format(_endDate!)}',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple.shade50,
                        foregroundColor: Colors.deepPurple,
                        padding: EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 24
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Additional Options
                    /*Row(
                      children: [
                        // Color Picker
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _showColorPicker,
                            icon: Icon(Icons.color_lens),
                            label: Text('Banner Color'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _bannerColor,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 24
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),

                        // Visibility Switch
                        Expanded(
                          child: SwitchListTile(
                            title: Text('Visible'),
                            value: _isVisibleToAll,
                            activeColor: Colors.deepPurple,
                            onChanged: (bool value) {
                              setState(() {
                                _isVisibleToAll = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),*/
                    SizedBox(height: 16),

                    // Priority Slider
                    /*Text(
                      'Banner Priority: ${_priority.round()}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.deepPurple),
                    ),
                    Slider(
                      value: _priority,
                      min: 0,
                      max: 10,
                      divisions: 10,
                      activeColor: Colors.deepPurple,
                      inactiveColor: Colors.deepPurple.shade100,
                      onChanged: (double value) {
                        setState(() {
                          _priority = value;
                        });
                      },
                    ),*/
                    SizedBox(height: 24),

                    // Submit Button
                    ElevatedButton(
                      onPressed: _submitBanner,
                      child: Text(
                        'Create Promotional Banner',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.projectButtonBlue2,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 32
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}