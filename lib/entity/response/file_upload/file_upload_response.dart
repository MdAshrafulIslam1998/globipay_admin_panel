import 'package:json_annotation/json_annotation.dart';
/**
 * Created by Abdullah on 6/12/24.
 */
part 'file_upload_response.g.dart';

@JsonSerializable()
class FileUploadResponse{
  String? url;
  String? doc_type;
  String? orginalName;
  String? mimetype;
  double? size;

  FileUploadResponse({
    this.url,
    this.doc_type,
    this.orginalName,
    this.mimetype,
    this.size,
  });

  factory FileUploadResponse.fromJson(Map<String, dynamic> json) => _$FileUploadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FileUploadResponseToJson(this);

}

