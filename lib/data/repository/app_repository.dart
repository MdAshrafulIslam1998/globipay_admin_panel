import 'package:globipay_admin_panel/core/data/model/pagination_request.dart';
import 'package:globipay_admin_panel/entity/request/login/login_request.dart';
import 'package:globipay_admin_panel/entity/response/login/login_response.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_entity.dart';

/**
 * Created by Abdullah on 13/10/24.
 */

abstract class AppRepository{

  Future<UserResponseEntity> requestForUserList(PaginationRequest paginationRequest,{String? path});
  Future<LoginResponse> requestForLogin(LoginRequest request);



}