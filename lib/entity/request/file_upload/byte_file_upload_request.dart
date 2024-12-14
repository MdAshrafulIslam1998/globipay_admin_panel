import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

/**
 * Created by Abdullah on 14/12/24.
 */


class ByteFileUploadRequest{
  Uint8List? bytes;
  String? fileName;
  String? doc_type;

  ByteFileUploadRequest({
    this.bytes,
    this.fileName,
    this.doc_type = "image/jpeg",
  });

  ByteFileUploadRequest.fromJson(Map<String, dynamic> json) {
    bytes = json['documents'];
    fileName = json['fileName'];
    doc_type = json['doc_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['documents'] = bytes;
    data['fileName'] = fileName;
    data['doc_type'] = doc_type;
    return data;
  }

  Future<FormData> toFormData()async {
    final formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(
        bytes ?? Uint8List(0), // Adjust the bytes if needed
        filename: fileName, // Set the filename for the uploaded file
        contentType: MediaType("image", "jpeg"), // Adjust MIME type if needed
      ),
    });

    return FormData.fromMap({
      "documents": formData ,
      "fileName":fileName ,
      "doc_type":doc_type ,
    });
  }
}