// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_upload_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileUploadResponse _$FileUploadResponseFromJson(Map<String, dynamic> json) =>
    FileUploadResponse(
      url: json['url'] as String?,
      doc_type: json['doc_type'] as String?,
      orginalName: json['orginalName'] as String?,
      mimetype: json['mimetype'] as String?,
      size: (json['size'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$FileUploadResponseToJson(FileUploadResponse instance) =>
    <String, dynamic>{
      'url': instance.url,
      'doc_type': instance.doc_type,
      'orginalName': instance.orginalName,
      'mimetype': instance.mimetype,
      'size': instance.size,
    };
