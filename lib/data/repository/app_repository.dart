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
import 'package:globipay_admin_panel/entity/response/category/category_item_entity.dart';
import 'package:globipay_admin_panel/entity/response/category/category_response.dart';
import 'package:globipay_admin_panel/entity/response/chat_close/chat_close_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/dashboard/dashboard_transaction_balance_entity.dart';
import 'package:globipay_admin_panel/entity/response/dashboard/recent_transaction_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/file_upload/file_upload_response.dart';
import 'package:globipay_admin_panel/entity/response/level/level_item_response_entity.dart';
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

import '../../entity/response/pagination/pagination.dart';

/**
 * Created by Abdullah on 13/10/24.
 */

abstract class AppRepository{

  Future<UserResponseEntity> requestForUserList(PaginationRequest paginationRequest,{String? path});
  Future<LoginResponse> requestForLogin(LoginRequest request);
  Future<ChatCloseResponseEntity> requestToCloseChat(ChatCloseRequestEntity request);
  Future<AllTransactionsResponseEntity> requestForAllTransactions(
      {required PaginationRequest paginationRequest,String? path});
  Future<AllTransactionsResponseEntity> requestForUserwiseTransactions(PaginationRequest paginationRequest);
   Future<AllTransactionsResponseEntity> requestForUserAmountDetails(
      {required PaginationRequest paginationRequest,String? path});
  Future<AddPromotionalBannerResponseEntity> requestToAddPromotionalBanner(AddPromotionalBannerRequestEntity request);
  Future<PromotionalBannerResponseEntity> requestForAllPromotionalBanner(PaginationRequest request);
  Future<FileUploadResponse> requestToFileUpload(FileUploadRequest request);
  Future<FileUploadResponse> requestToByteFileUpload(ByteFileUploadRequest request);
  Future<void> requestToRemoveBanner(PromotionalBannerDeleteRequestEntity request);
  Future<MiscResponseEntity> requestForMisc(PaginationRequest paginationRequest);
  Future<CategoryResponseEntity> requestForCategories(PaginationRequest request);
  Future<void> requestToAddMessageTemplates(AddMessageTemplatesRequest request);
  Future<MessagesTemplatesResponseEntity> requestForMessageTemplates(PaginationRequest request);
  Future<void> requestToRemoveMessageTemplates(String id);
  Future<void> requestToAddCategory(AddCategoryRequestEntity req);
  Future<void> requestToDeleteCategory(String id);
  Future<void> requestToAddMisc(AddMiscRequestEntity request);
  Future<void> requestToRemoveMisc(String id);
  Future<void> requestToRemoveLevel(String id);
  Future<LevelResponseEntity> requestForAllLevel();
  Future requestToAddLevel(AddLevelRequestEntity req);
  Future<StaffResponseEntity> requestForStaffList(PaginationRequest req);
  Future<void> requestToAddStaff(AddStaffRequestEntity req);
  Future<void> requestToRemoveStaff(String req);
  Future<List<NotificationResponseItemEntity>> requestForAllNotifications();
  Future<UserResponseEntity> requestForSearchUserList(PaginationRequest paginationRequest);
  Future<void> requestToTriggerNotification(CreateNotificationRequestEntity request);
  Future<UserTransactionHistoryResponseEntity> requestUserSpecificTransaction(
  {required PaginationRequest request, required String userId});

  Future<AgoraTokenResponseEntity> requestForAgoraToken(AgoraTokenRequestEntity request);
  Future<String> requestToSendCallNotification(SendCallRequestEntity request);

  Future<NotificationResponseEntity> requestUserSpecificNotification(
      {required PaginationRequest request, required String userId});

  Future<void> requestToUpdateUserStatus(String userId, UserStatus status);
  Future<void> requestToRemoveNotification(String notificationId);
  Future<DashboardTransactionBalanceEntity> requestForDashboardBalance();
  Future<List<RecentTransactionResponseEntity>> requestForRecentTransactionHistory();
  Future requestToUpdateCategory(CategoryItemEntity req);

}