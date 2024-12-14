import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

/**
 * Created by Abdullah on 6/12/24.
 */

class FileUploadRequest{
  String? documents;
  String? fileName;
  String? doc_type;

  FileUploadRequest({
    this.documents,
    this.fileName,
    this.doc_type = "image/png",
  });

  FileUploadRequest.fromJson(Map<String, dynamic> json) {
    documents = json['file'];
    fileName = json['fileName'];
    doc_type = json['doc_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['documents'] = documents;
    data['fileName'] = fileName;
    data['doc_type'] = doc_type;
    return data;
  }

  Future<FormData> toFormData()async {
    var mfile = await MultipartFile.fromFile(documents ?? "",
        contentType: MediaType(
          "image",
          "jpeg",
        ),
        filename: fileName ?? "image.jpeg");

    return FormData.fromMap({
      "documents":mfile ,
      "fileName":fileName ,
      "doc_type":doc_type ,
    });
  }
}