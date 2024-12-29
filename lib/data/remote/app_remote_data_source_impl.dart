import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:globipay_admin_panel/core/constants/enum/user_status.dart';
import 'package:globipay_admin_panel/entity/request/agora/agora_token_request_entity.dart';
import 'package:globipay_admin_panel/entity/request/call/send_call_request_entity.dart';
import 'package:globipay_admin_panel/entity/request/category/add_category_request_entity.dart';
import 'package:globipay_admin_panel/entity/request/level/add_level_request_entity.dart';
import 'package:globipay_admin_panel/entity/request/misc/add_misc_request_entity.dart';
import 'package:globipay_admin_panel/entity/request/notification/create_notification_request_entity.dart';
import 'package:globipay_admin_panel/entity/request/promotional_banner_delete/promotional_banner_delete_entity.dart';
import 'package:globipay_admin_panel/entity/request/staff/add_staff_request_entity.dart';
import 'package:globipay_admin_panel/entity/request/user_profile_request/update_user_status_request.dart';
import 'package:globipay_admin_panel/entity/response/agora/agora_token_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/category/category_response.dart';
import 'package:globipay_admin_panel/entity/response/dashboard/dashboard_transaction_balance_entity.dart';
import 'package:globipay_admin_panel/entity/response/dashboard/recent_transaction_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/level/level_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/messages_templates/messages_templates_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/misc/misc_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/notification/notification_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/notification/notification_response_item_entity.dart';
import 'package:globipay_admin_panel/entity/response/staff/staff_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/user_profile/user_profile_details_response.dart';
import 'package:globipay_admin_panel/entity/response/user_profile_response/update_user_status_response.dart';
import 'package:globipay_admin_panel/entity/response/user_transaction_history/user_transaction_history_response.dart';
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
import 'package:globipay_admin_panel/entity/response/trans_history_response.dart/all_transactions_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_entity.dart';

import '../../../flavors/flavor_config.dart';
import '../../entity/request/message_templates/add_message_templates_request.dart';
import '../../entity/response/pagination/pagination.dart';
import 'app_remote_data_source.dart';

/**
 * Created by Abdullah on 13/10/24.
 */

class AppRemoteDataSourceImpl extends BaseRemoteSource
    implements AppRemoteDataSource {
  final String BASE_URL = FlavorConfig.instance.url;

  final TokenRepository tokenRepository = Injector.resolve<TokenRepository>();

  @override
  Future<UserResponseEntity> requestForUserList(PaginationRequest request,
      {String? path}) async {
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

  @override
  Future<void> requestToRemoveMisc(String id) {
    var endpoint = '$BASE_URL/${AppApi.removeMisc}/$id';
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
  Future<void> requestToRemoveLevel(String id) {
    var endpoint = '$BASE_URL/${AppApi.removeLevel}/$id';
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
  Future<LevelResponseEntity> requestForAllLevel() {
    var endpoint = '$BASE_URL/${AppApi.allLevel}';
    var dioCall = dioClientWithAuth.get(
      endpoint,
    );
    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => LevelResponseEntity.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future requestToAddLevel(AddLevelRequestEntity req) {
    var endpoint = '$BASE_URL/${AppApi.addLevel}';
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
  Future<StaffResponseEntity> requestForStaffList(PaginationRequest req) {
    var endpoint = '$BASE_URL/${AppApi.staffList}';
    var dioCall = dioClientWithAuth.get(
      endpoint,
      queryParameters: req.toJson(),
    );
    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => StaffResponseEntity.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> requestToAddStaff(AddStaffRequestEntity req) {
    var endpoint = '$BASE_URL/${AppApi.addStaff}';
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
  Future<void> requestToRemoveStaff(String id) {
    var endpoint = '$BASE_URL/${AppApi.addStaff}/$id';
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
  Future<AllTransactionsResponseEntity> requestForAllTransactions({required PaginationRequest paginationRequest, String? path}) async{
    // Get the staff ID from the token repository or a similar source
    final staffId = await tokenRepository.getStuffId();

    // Define the endpoint for the allTransactions API, including the staff ID
    var endpoint = '$BASE_URL/${path ?? AppApi.allTransactions}/$staffId';

    // Prepare the Dio call with authentication and query parameters
    var dioCall = dioClientWithAuth.get(
      endpoint,
      queryParameters: paginationRequest.toJson(),
    );

    // Execute the call and parse the response into the model
    try {
      return callApiWithErrorParser(dioCall).then((response) {
        return AllTransactionsResponseEntity.fromJson(response.data);
      });
    } catch (e) {
      rethrow; // Pass the error to the calling layer for centralized error handling
    }
  }



  @override
  Future<AllTransactionsResponseEntity> requestForUserAmountDetails({required PaginationRequest paginationRequest, String? path}) async{
    // Get the staff ID from the token repository or a similar source
    final staffId = await tokenRepository.getStuffId();

    // Define the endpoint for the allTransactions API, including the staff ID
    var endpoint = '$BASE_URL/${AppApi.userAmountDetails}/$staffId';

    // Prepare the Dio call with authentication and query parameters
    var dioCall = dioClientWithAuth.get(
      endpoint,
      queryParameters: paginationRequest.toJson(),
    );

    // Execute the call and parse the response into the model
    try {
      return callApiWithErrorParser(dioCall).then((response) {
        return AllTransactionsResponseEntity.fromJson(response.data);
      });
    } catch (e) {
      rethrow; // Pass the error to the calling layer for centralized error handling
    }
  }


  

  @override
  Future<AllTransactionsResponseEntity> requestForUserwiseTransactions(
      PaginationRequest paginationRequest) async {
    // Get the staff ID from the token repository or a similar source
    final staffId = await tokenRepository.getStuffId();

    // Define the endpoint for the allTransactions API, including the staff ID
    var endpoint = '$BASE_URL/${AppApi.userwiseTransactions}/$staffId';

    // Prepare the Dio call with authentication and query parameters
    var dioCall = dioClientWithAuth.get(
      endpoint,
      queryParameters: paginationRequest.toJson(),
    );

    // Execute the call and parse the response into the model
    try {
      return callApiWithErrorParser(dioCall).then((response) {
        return AllTransactionsResponseEntity.fromJson(response.data);
      });
    } catch (e) {
      rethrow; // Pass the error to the calling layer for centralized error handling
    }
  }



  @override
  Future<List<NotificationResponseItemEntity>> requestForAllNotifications() {
    var endpoint = '$BASE_URL/${AppApi.notifications}';
    var dioCall = dioClientWithAuth.get(
      endpoint,
    );
    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => (response.data as List).map((e) => NotificationResponseItemEntity.fromJson(e)).toList());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserResponseEntity> requestForSearchUserList(PaginationRequest paginationRequest) {
    var endpoint = '$BASE_URL/${AppApi.searchUser}';
    var dioCall = dioClientWithAuth.get(
      endpoint,
      queryParameters: paginationRequest.toJson(),
    );
    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => UserResponseEntity.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> requestToTriggerNotification(CreateNotificationRequestEntity request) {
    var endpoint = '$BASE_URL/${AppApi.createNotifications}';
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
  Future<UserTransactionHistoryResponseEntity> requestUserSpecificTransaction({required PaginationRequest request, required String userId}) {
    var endpoint = '$BASE_URL/${AppApi.userSpecificTransactionHistory}/$userId/transactions';
    var dioCall = dioClientWithAuth.get(
      endpoint,
      queryParameters: request.toJson(),
    );
    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => UserTransactionHistoryResponseEntity.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AgoraTokenResponseEntity> requestForAgoraToken(AgoraTokenRequestEntity request) {
    var endpoint = '$BASE_URL/${AppApi.agoraToken}';
    var dioCall = dioClientWithAuth.post(
      endpoint,
      data: request.toJson(),
    );
    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => AgoraTokenResponseEntity.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> requestToSendCallNotification(SendCallRequestEntity request) {
    var endpoint = '$BASE_URL/${AppApi.callSend}';
    var dioCall = dioClientWithAuth.post(
      endpoint,
      data: request.toJson(),
    );
    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => response.data.toString());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<NotificationResponseEntity> requestUserSpecificNotification({required PaginationRequest request, required String userId}) {
    var endpoint = '$BASE_URL/${AppApi.userSpecificNotifications}';
    var dioCall = dioClientWithAuth.post(
      endpoint,
      data: {
        ...request.toJson(),
        'target_id': userId,
      },
    );
    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => NotificationResponseEntity.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }


  
   
  @override
  Future<void> requestToUpdateUserStatus(String userId, UserStatus status) {
    var endpoint = '$BASE_URL/${AppApi.userStatus}/$userId';
    var dioCall = dioClientWithAuth.post(
      endpoint,
      data: {
        'status': status.name,
      },
    );
    try {
      return callApiWithErrorParser(dioCall);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> requestToRemoveNotification(String notificationId) {
    var endpoint = '$BASE_URL/${AppApi.deleteNotification}/$notificationId';
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
  Future<DashboardTransactionBalanceEntity> requestForDashboardBalance() {
    var endpoint = '$BASE_URL/${AppApi.totalTransactions}';
    var dioCall = dioClientWithAuth.get(
      endpoint,
    );
    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => DashboardTransactionBalanceEntity.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<RecentTransactionResponseEntity>> requestForRecentTransactionHistory() {
    var endpoint = '$BASE_URL/${AppApi.recentTransaction}';
    var dioCall = dioClientWithAuth.get(
      endpoint,
    );
    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => (response.data as List).map((e) => RecentTransactionResponseEntity.fromJson(e)).toList());
    } catch (e) {
      rethrow;
    }
  }


  @override
  Future<UserProfileData> getUserProfileDetails(String userId) async {
    var endpoint = '$BASE_URL/${AppApi.userProfileDetails}/$userId';
    var dioCall = dioClientWithAuth.get(endpoint);
    
    try {
      return callApiWithErrorParser(dioCall).then(
        (response) => UserProfileData.fromJson(response.data)
      );
    } catch (e) {
      rethrow;
    }
  }


   @override
  Future<UserData> updateUserStatus(String userId, UpdateUserStatusRequest request) {
    var endpoint = '$BASE_URL/${AppApi.updateUserStatus}/$userId';
    var dioCall = dioClientWithAuth.put(
      endpoint,
      data: request.toJson(),
    );
    try {
      return callApiWithErrorParser(dioCall).then((response) =>
          UserData.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }
}
