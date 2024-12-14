import 'package:globipay_admin_panel/core/data/model/pagination_request.dart';
import 'package:globipay_admin_panel/entity/request/chat_close/chat_close_request_entity.dart';
import 'package:globipay_admin_panel/entity/request/login/login_request.dart';
import 'package:globipay_admin_panel/entity/response/chat_close/chat_close_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/login/login_response.dart';
import 'package:globipay_admin_panel/entity/response/trans_history_response.dart/all_transactions_response_entity.dart';

import 'package:globipay_admin_panel/entity/response/user_response/user_response_entity.dart';

import '../remote/app_remote_data_source.dart';
import '../repository/app_repository.dart';

/**
 * Created by Abdullah on 13/10/24.
 */

class AppRepositoryImpl extends AppRepository {
  AppRemoteDataSource remoteDataSource;
  AppRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserResponseEntity> requestForUserList(
      PaginationRequest paginationRequest,
      {String? path}) {
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
  Future<AllTransactionsResponseEntity> requestForAllTransactions(
    PaginationRequest paginationRequest,
    ) {
    return remoteDataSource.requestForAllTransactions(paginationRequest);
  }

  @override
  Future<AllTransactionsResponseEntity> requestForUserwiseTransactions(
    PaginationRequest paginationRequest,
    ) {
    return remoteDataSource.requestForUserwiseTransactions(paginationRequest);
  }
}
