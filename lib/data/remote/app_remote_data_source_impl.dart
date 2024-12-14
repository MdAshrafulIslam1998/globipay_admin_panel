import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:globipay_admin_panel/entity/request/category/add_category_request_entity.dart';
import 'package:globipay_admin_panel/entity/request/misc/add_misc_request_entity.dart';
import 'package:globipay_admin_panel/entity/request/promotional_banner_delete/promotional_banner_delete_entity.dart';
import 'package:globipay_admin_panel/entity/response/category/category_response.dart';
import 'package:globipay_admin_panel/entity/response/messages_templates/messages_templates_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/misc/misc_response_entity.dart';
import 'package:http_parser/http_parser.dart';
import 'package:globipay_admin_panel/core/base/base_remote_source.dart';
import 'package:globipay_admin_panel/core/data/local/repository/token_repository.dart';
import 'package:globipay_admin_panel/core/data/model/pagination_request.dart';
import 'package:globipay_admin_panel/core/di/injector.dart';
import 'package:globipay_admin_panel/data/api/app_api.dart';
import 'package:globipay_admin_panel/entity/request/chat_close/chat_close_request_entity.dart';
import 'package:globipay_admin_panel/entity/request/file_upload/byte_file_upload_request.dart';
import 'package:globipay_admin_panel/entity/request/file_upload/file_upload_request.dart';
import 'package:globipay_admin_panel/entity/request/login/login_request.dart';
import 'package:globipay_admin_panel/entity/request/promotional/add_promotional_banner_request_entity.dart';
import 'package:globipay_admin_panel/entity/response/chat_close/chat_close_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/file_upload/file_upload_response.dart';
import 'package:globipay_admin_panel/entity/response/login/login_response.dart';
import 'package:globipay_admin_panel/entity/response/promotional/add_promotional_banner_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/promotional/promotional_banner_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_entity.dart';

import '../../../flavors/flavor_config.dart';
import '../../entity/request/message_templates/add_message_templates_request.dart';
import 'app_remote_data_source.dart';

/**
 * Created by Abdullah on 13/10/24.
 */

class AppRemoteDataSourceImpl extends BaseRemoteSource
    implements AppRemoteDataSource {
  final String BASE_URL = FlavorConfig.instance.url;

  final TokenRepository tokenRepository = Injector.resolve<TokenRepository>();

  @override
  Future<UserResponseEntity> requestForUserList(PaginationRequest request, {String? path}) async{
    final staffId = await tokenRepository.getStuffId();
    var endpoint = '$BASE_URL/${path ?? AppApi.userVerifiedProfile}/$staffId';
    var dioCall = dioClientWithAuth.get(
      endpoint,
      queryParameters: request.toJson(),
    );
    try {
      return callApiWithErrorParser(dioCall).then((response) =>
          UserResponseEntity.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LoginResponse> requestForLogin(LoginRequest request) {
    var endpoint = '$BASE_URL/${AppApi.login}';
    var dioCall = dioClient.post(
      endpoint,
      data: request.toJson(),
    );
    try {
      return callApiWithErrorParser(dioCall).then((response) =>
          LoginResponse.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ChatCloseResponseEntity> requestToCloseChat(ChatCloseRequestEntity request) {
    var endpoint = '$BASE_URL/${AppApi.chatClose}';
    var dioCall = dioClientWithAuth.post(
      endpoint,
      data: request.toJson(),
    );
    try {
      return callApiWithErrorParser(dioCall).then((response) =>
          ChatCloseResponseEntity.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AddPromotionalBannerResponseEntity> requestToAddPromotionalBanner(AddPromotionalBannerRequestEntity request){
    var endpoint = '$BASE_URL/${AppApi.addSlider}';
    var dioCall = dioClientWithAuth.post(
      endpoint,
      data: request.toJson(),
    );
    try {
      return callApiWithErrorParser(dioCall).then((response) =>
          AddPromotionalBannerResponseEntity.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PromotionalBannerResponseEntity> requestForAllPromotionalBanner(PaginationRequest request){
    var endpoint = '$BASE_URL/${AppApi.allSlider}';
    var dioCall = dioClientWithAuth.get(
      endpoint,
      queryParameters: request.toJson(),
    );
    try {
      return callApiWithErrorParser(dioCall).then((response) =>
          PromotionalBannerResponseEntity.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<FileUploadResponse> requestToFileUpload(FileUploadRequest request) async{

    var endpoint = '$BASE_URL/${AppApi.fileUpload}';
    var fileData = await request.toFormData();
    var dioCall = dioClientWithAuth.post(
      endpoint,
      data: fileData,
      options: Options(
        headers: {
          "Content-Type": "multipart/form-data", // Explicitly set Content-Type
        },
      ),
    );
    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => FileUploadResponse.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<FileUploadResponse> requestToByteFileUpload(ByteFileUploadRequest request) async{
    var endpoint = '$BASE_URL/${AppApi.fileUpload}';
    final fileData = FormData.fromMap({
      'doc_type' : "other",
      "documents": MultipartFile.fromBytes(
        request.bytes ?? Uint8List(0), // Adjust the bytes if needed
        filename: request.fileName, // Set the filename for the uploaded file
        contentType: MediaType("image", "jpeg"), // Adjust MIME type if needed
      ),
    });    var dioCall = dioClientWithAuth.post(
      endpoint,
      data: fileData,
      options: Options(
        headers: {
          "Content-Type": "multipart/form-data", // Explicitly set Content-Type
        },
      ),
    );
    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => FileUploadResponse.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> requestToRemoveBanner(PromotionalBannerDeleteRequestEntity request) {
    var endpoint = '$BASE_URL/${AppApi.deleteSlide}';
    var dioCall = dioClientWithAuth.post(
      endpoint,
      data: request.toJson(),
    );
    try {
      return callApiWithErrorParser(dioCall);
    } catch (e) {
      rethrow;
    }

  }

  @override
  Future<MiscResponseEntity> requestForMisc(PaginationRequest request) {
    var endpoint = '$BASE_URL/${AppApi.miscs}';
    var dioCall = dioClientWithAuth.get(
      endpoint,
      queryParameters: request.toJson(),
    );
    try {
      // Return a dummy response her
      return callApiWithErrorParser(dioCall)
          .then((response) => MiscResponseEntity.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CategoryResponseEntity> requestForCategories(PaginationRequest request) {
    var endpoint = '$BASE_URL/${AppApi.categories}';
    var dioCall = dioClientWithAuth.get(
      endpoint,
      queryParameters: request.toJson(),
    );

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => CategoryResponseEntity.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> requestToAddMessageTemplates(AddMessageTemplatesRequest request) {
    var endpoint = '$BASE_URL/${AppApi.addMessageTemplates}';
    var dioCall = dioClientWithAuth.post(
      endpoint,
      data: request.toJson(),
    );
    try {
      return callApiWithErrorParser(dioCall);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MessagesTemplatesResponseEntity> requestForMessageTemplates(PaginationRequest request) {
    var endpoint = '$BASE_URL/${AppApi.messageTemplatesList}';
    var dioCall = dioClientWithAuth.get(
      endpoint,
      queryParameters: request.toJson(),
    );
    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => MessagesTemplatesResponseEntity.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> requestToRemoveMessageTemplates(String id) {
    var endpoint = '$BASE_URL/${AppApi.removeMessageTemplates}/$id';
    var dioCall = dioClientWithAuth.delete(
      endpoint,
    );
    try {
      return callApiWithErrorParser(dioCall);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> requestToAddCategory(AddCategoryRequestEntity req) {
    var endpoint = '$BASE_URL/${AppApi.addCategory}';
    var dioCall = dioClientWithAuth.post(
      endpoint,
      data: req.toJson(),
    );
    try {
      return callApiWithErrorParser(dioCall);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> requestToDeleteCategory(String id) {
    var endpoint = '$BASE_URL/${AppApi.deleteCategory}/$id';
    var dioCall = dioClientWithAuth.delete(
      endpoint,
    );
    try {
      return callApiWithErrorParser(dioCall);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> requestToAddMisc(AddMiscRequestEntity request) {
    var endpoint = '$BASE_URL/${AppApi.addMisc}';
    var dioCall = dioClientWithAuth.post(
      endpoint,
      data: request.toJson(),
    );
    try {
      return callApiWithErrorParser(dioCall);
    } catch (e) {
      rethrow;
    }
  }







}
