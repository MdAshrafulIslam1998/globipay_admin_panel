import 'package:globipay_admin_panel/core/data/model/pagination_request.dart';
import 'package:globipay_admin_panel/entity/request/chat_close/chat_close_request_entity.dart';
import 'package:globipay_admin_panel/entity/request/file_upload/byte_file_upload_request.dart';
import 'package:globipay_admin_panel/entity/request/file_upload/file_upload_request.dart';
import 'package:globipay_admin_panel/entity/request/login/login_request.dart';
import 'package:globipay_admin_panel/entity/request/promotional/add_promotional_banner_request_entity.dart';
import 'package:globipay_admin_panel/entity/request/promotional_banner_delete/promotional_banner_delete_entity.dart';
import 'package:globipay_admin_panel/entity/response/chat_close/chat_close_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/file_upload/file_upload_response.dart';
import 'package:globipay_admin_panel/entity/response/login/login_response.dart';
import 'package:globipay_admin_panel/entity/response/misc/misc_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/promotional/add_promotional_banner_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/promotional/promotional_banner_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_entity.dart';

/**
 * Created by Abdullah on 13/10/24.
 */

abstract class AppRepository{

  Future<UserResponseEntity> requestForUserList(PaginationRequest paginationRequest,{String? path});
  Future<LoginResponse> requestForLogin(LoginRequest request);
  Future<ChatCloseResponseEntity> requestToCloseChat(ChatCloseRequestEntity request);
  Future<AddPromotionalBannerResponseEntity> requestToAddPromotionalBanner(AddPromotionalBannerRequestEntity request);
  Future<PromotionalBannerResponseEntity> requestForAllPromotionalBanner(PaginationRequest request);
  Future<FileUploadResponse> requestToFileUpload(FileUploadRequest request);
  Future<FileUploadResponse> requestToByteFileUpload(ByteFileUploadRequest request);
  Future<void> requestToRemoveBanner(PromotionalBannerDeleteRequestEntity request);
  Future<MiscResponseEntity> requestForMisc(PaginationRequest paginationRequest);




}