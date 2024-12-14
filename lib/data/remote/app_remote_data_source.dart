
import 'package:globipay_admin_panel/core/data/model/pagination_request.dart';
import 'package:globipay_admin_panel/entity/request/chat_close/chat_close_request_entity.dart';
import 'package:globipay_admin_panel/entity/request/login/login_request.dart';
import 'package:globipay_admin_panel/entity/response/chat_close/chat_close_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/login/login_response.dart';
import 'package:globipay_admin_panel/entity/response/trans_history_response.dart/all_transactions_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_entity.dart';

/**
 * Created by Abdullah on 13/10/24.
 */


abstract class AppRemoteDataSource {
  Future<UserResponseEntity> requestForUserList(PaginationRequest paginationRequest,{String? path});
  Future<LoginResponse> requestForLogin(LoginRequest request);
  Future<ChatCloseResponseEntity> requestToCloseChat(ChatCloseRequestEntity request);
  Future<AllTransactionsResponseEntity> requestForAllTransactions(PaginationRequest paginationRequest);
  Future<AllTransactionsResponseEntity> requestForUserwiseTransactions(PaginationRequest paginationRequest);

}