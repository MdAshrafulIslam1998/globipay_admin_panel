import 'dart:html' as html;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/widgets/app_print.dart';

/// Created by Abdullah on 14/12/24.
class WebImagePicker extends StatefulWidget {
  final double? height;
  final double? width;
  Function(Uint8List?, html.File?) onImageSelected;
  final String? hint;

  WebImagePicker({super.key, required this.onImageSelected, this.hint, this.height, this.width});

  @override
  _WebImagePickerState createState() => _WebImagePickerState();
}

class _WebImagePickerState extends State<WebImagePicker> {
  Uint8List? _imageBytes;

  // Function to pick an image using <input type="file">
  void pickImage() {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*'; // Only allow image files
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files != null && files.isNotEmpty) {
        final file = files[0];
        final reader = html.FileReader();

        reader.readAsArrayBuffer(file);
        appPrint("Selected file::::::::;: ${file.name}");
        appPrint("Selected file::::::::;: ${file.toString()}");
        reader.onLoadEnd.listen((e) {
          setState(() {
            // Convert the file to bytes
            _imageBytes = reader.result as Uint8List;
            widget.onImageSelected.call(_imageBytes, file);
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () {
            pickImage();
          },
          child: Container(
            height: widget.height ?? 250,
            width: widget.width ?? 250,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _imageBytes != null
                    ? Colors.transparent
                    : Colors.deepPurple.shade200,
                style: BorderStyle.solid,
                width: 2,
              ),
            ),
            child: _imageBytes != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: _buildImageDisplay(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload,
                        size: 80,
                        color: Colors.deepPurple.shade300,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.hint ?? 'Upload Image',
                        style: TextStyle(
                          color: Colors.deepPurple.shade400,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageDisplay() {
    if (_imageBytes == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_upload,
            size: 80,
            color: Colors.deepPurple.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'Upload Banner Image',
            style: TextStyle(
              color: Colors.deepPurple.shade400,
              fontSize: 18,
            ),
          ),
        ],
      );
    }

    // Cross-platform image display
    return Image.memory(_imageBytes!);
  }
}
