import 'package:globipay_admin_panel/core/base/base_remote_source.dart';
import 'package:globipay_admin_panel/core/data/local/repository/token_repository.dart';
import 'package:globipay_admin_panel/core/data/model/pagination_request.dart';
import 'package:globipay_admin_panel/core/di/injector.dart';
import 'package:globipay_admin_panel/data/api/app_api.dart';
import 'package:globipay_admin_panel/entity/request/chat_close/chat_close_request_entity.dart';
import 'package:globipay_admin_panel/entity/request/login/login_request.dart';
import 'package:globipay_admin_panel/entity/response/chat_close/chat_close_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/login/login_response.dart';
import 'package:globipay_admin_panel/entity/response/trans_history_response.dart/all_transactions_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_entity.dart';

import '../../../flavors/flavor_config.dart';
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
      return callApiWithErrorParser(dioCall)
          .then((response) => UserResponseEntity.fromJson(response.data));
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
      return callApiWithErrorParser(dioCall)
          .then((response) => LoginResponse.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ChatCloseResponseEntity> requestToCloseChat(
      ChatCloseRequestEntity request) {
    var endpoint = '$BASE_URL/${AppApi.chatClose}';
    var dioCall = dioClientWithAuth.post(
      endpoint,
      data: request.toJson(),
    );
    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => ChatCloseResponseEntity.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }


  @override
  Future<AllTransactionsResponseEntity> requestForAllTransactions(
      PaginationRequest paginationRequest) async {
    // Get the staff ID from the token repository or a similar source
    final staffId = await tokenRepository.getStuffId();

    // Define the endpoint for the allTransactions API, including the staff ID
    var endpoint = '$BASE_URL/${AppApi.allTransactions}/$staffId';

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
}
