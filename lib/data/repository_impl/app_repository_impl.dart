import 'package:globipay_admin_panel/core/constants/enum/user_status.dart';
import 'package:globipay_admin_panel/core/data/model/pagination_request.dart';
import 'package:globipay_admin_panel/entity/request/agora/agora_token_request_entity.dart';
import 'package:globipay_admin_panel/entity/request/call/send_call_request_entity.dart';
import 'package:globipay_admin_panel/entity/request/category/add_category_request_entity.dart';
import 'package:globipay_admin_panel/entity/request/chat_close/chat_close_request_entity.dart';
import 'package:globipay_admin_panel/entity/request/file_upload/byte_file_upload_request.dart';
import 'package:globipay_admin_panel/entity/request/file_upload/file_upload_request.dart';
import 'package:globipay_admin_panel/entity/request/level/add_level_request_entity.dart';
import 'package:globipay_admin_panel/entity/request/login/login_request.dart';
import 'package:globipay_admin_panel/entity/request/message_templates/add_message_templates_request.dart';
import 'package:globipay_admin_panel/entity/request/misc/add_misc_request_entity.dart';
import 'package:globipay_admin_panel/entity/request/notification/create_notification_request_entity.dart';
import 'package:globipay_admin_panel/entity/request/promotional/add_promotional_banner_request_entity.dart';
import 'package:globipay_admin_panel/entity/request/promotional_banner_delete/promotional_banner_delete_entity.dart';
import 'package:globipay_admin_panel/entity/request/staff/add_staff_request_entity.dart';
import 'package:globipay_admin_panel/entity/response/agora/agora_token_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/category/category_response.dart';
import 'package:globipay_admin_panel/entity/response/chat_close/chat_close_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/file_upload/file_upload_response.dart';
import 'package:globipay_admin_panel/entity/response/level/level_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/login/login_response.dart';
import 'package:globipay_admin_panel/entity/response/messages_templates/messages_templates_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/misc/misc_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/notification/notification_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/notification/notification_response_item_entity.dart';
import 'package:globipay_admin_panel/entity/response/promotional/add_promotional_banner_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/promotional/promotional_banner_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/staff/staff_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/trans_history_response.dart/all_transactions_response_entity.dart';

import 'package:globipay_admin_panel/entity/response/user_response/user_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/user_transaction_history/user_transaction_history_item_response.dart';
import 'package:globipay_admin_panel/entity/response/user_transaction_history/user_transaction_history_response.dart';

import '../remote/app_remote_data_source.dart';
import '../repository/app_repository.dart';

/**
 * Created by Abdullah on 13/10/24.
 */

class AppRepositoryImpl extends AppRepository {
  AppRemoteDataSource remoteDataSource;
  AppRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserResponseEntity> requestForUserList(PaginationRequest paginationRequest, {String? path}) {
    return remoteDataSource.requestForUserList(paginationRequest, path: path);
  }

  

  @override
  Future<LoginResponse> requestForLogin(LoginRequest request) {
    return remoteDataSource.requestForLogin(request);
  }

  @override
  Future<ChatCloseResponseEntity> requestToCloseChat(
      ChatCloseRequestEntity request) {
    return remoteDataSource.requestToCloseChat(request);
  }

  @override
  Future<AddPromotionalBannerResponseEntity> requestToAddPromotionalBanner(AddPromotionalBannerRequestEntity request) {
    return remoteDataSource.requestToAddPromotionalBanner(request);
  }

  @override
  Future<PromotionalBannerResponseEntity> requestForAllPromotionalBanner(PaginationRequest request) {
    return remoteDataSource.requestForAllPromotionalBanner(request);
  }

  @override
  Future<FileUploadResponse> requestToFileUpload(FileUploadRequest request) {
    return remoteDataSource.requestToFileUpload(request);
  }

  @override
  Future<FileUploadResponse> requestToByteFileUpload(ByteFileUploadRequest request) {
    return remoteDataSource.requestToByteFileUpload(request);
  }

  @override
  Future<void> requestToRemoveBanner(PromotionalBannerDeleteRequestEntity request) {
    return remoteDataSource.requestToRemoveBanner(request);
  }

  @override
  Future<MiscResponseEntity> requestForMisc(PaginationRequest paginationRequest) {
    return remoteDataSource.requestForMisc(paginationRequest);
  }

  @override
  Future<CategoryResponseEntity> requestForCategories(PaginationRequest request) {
    return remoteDataSource.requestForCategories(request);
  }

  @override
  Future<void> requestToAddMessageTemplates(AddMessageTemplatesRequest request) {
    return remoteDataSource.requestToAddMessageTemplates(request);
  }

  @override
  Future<MessagesTemplatesResponseEntity> requestForMessageTemplates(PaginationRequest request) {
    return remoteDataSource.requestForMessageTemplates(request);
  }

  @override
  Future<void> requestToRemoveMessageTemplates(String id) {
    return remoteDataSource.requestToRemoveMessageTemplates(id);
  }

  @override
  Future<void> requestToAddCategory(AddCategoryRequestEntity req) {
   return remoteDataSource.requestToAddCategory(req);
  }

  @override
  Future<void> requestToDeleteCategory(String id) {
    return remoteDataSource.requestToDeleteCategory(id);
  }

  @override
  Future<void> requestToAddMisc(AddMiscRequestEntity request) {
    return remoteDataSource.requestToAddMisc(request);
  }

  @override
  Future<void> requestToRemoveMisc(String id) {
    return remoteDataSource.requestToRemoveMisc(id);
  }



  @override
  Future<AllTransactionsResponseEntity> requestForUserwiseTransactions(
    PaginationRequest paginationRequest,
    ) {
    return remoteDataSource.requestForUserwiseTransactions(paginationRequest);
  }

  @override
  Future<void> requestToRemoveLevel(String id) {
    return remoteDataSource.requestToRemoveLevel(id);
  }

  @override
  Future<LevelResponseEntity> requestForAllLevel() {
    return remoteDataSource.requestForAllLevel();
  }

  @override
  Future requestToAddLevel(AddLevelRequestEntity req) {
    return remoteDataSource.requestToAddLevel(req);
  }

  @override
  Future<StaffResponseEntity> requestForStaffList(PaginationRequest req) {
    return remoteDataSource.requestForStaffList(req);
  }

  @override
  Future<void> requestToAddStaff(AddStaffRequestEntity req) {
    return remoteDataSource.requestToAddStaff(req);
  }

  @override
  Future<void> requestToRemoveStaff(String req) {
    return remoteDataSource.requestToRemoveStaff(req);
  }

  @override
  Future<AllTransactionsResponseEntity> requestForAllTransactions({required PaginationRequest paginationRequest, String? path}) {
    return remoteDataSource.requestForAllTransactions(paginationRequest : paginationRequest, path: path);
  }

  @override
  Future<List<NotificationResponseItemEntity>> requestForAllNotifications() {
    return remoteDataSource.requestForAllNotifications();
  }

  @override
  Future<UserResponseEntity> requestForSearchUserList(PaginationRequest paginationRequest) {
    return remoteDataSource.requestForSearchUserList(paginationRequest);
  }

  @override
  Future<void> requestToTriggerNotification(CreateNotificationRequestEntity request) {
    return remoteDataSource.requestToTriggerNotification(request);
  }

  @override
  Future<UserTransactionHistoryResponseEntity> requestUserSpecificTransaction({required PaginationRequest request, required String userId}) {
    return remoteDataSource.requestUserSpecificTransaction(request: request, userId: userId);
  }

  @override
  Future<AgoraTokenResponseEntity> requestForAgoraToken(AgoraTokenRequestEntity request) {
    return remoteDataSource.requestForAgoraToken(request);
  }

  @override
  Future<String> requestToSendCallNotification(SendCallRequestEntity request) {
    return remoteDataSource.requestToSendCallNotification(request);
  }

  @override
  Future<NotificationResponseEntity> requestUserSpecificNotification({required PaginationRequest request, required String userId}) {
    return remoteDataSource.requestUserSpecificNotification(request: request, userId: userId);
  }

  @override
  Future<void> requestToUpdateUserStatus(String userId, UserStatus status) {
    return remoteDataSource.requestToUpdateUserStatus(userId, status);
  }

  @override
  Future<void> requestToRemoveNotification(String notificationId) {
    return remoteDataSource.requestToRemoveNotification(notificationId);
  }







}
