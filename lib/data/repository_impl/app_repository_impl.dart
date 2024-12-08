import 'package:globipay_admin_panel/core/data/model/pagination_request.dart';
import 'package:globipay_admin_panel/entity/request/login/login_request.dart';
import 'package:globipay_admin_panel/entity/response/login/login_response.dart';

import 'package:globipay_admin_panel/entity/response/user_response/user_response_entity.dart';

import '../remote/app_remote_data_source.dart';
import '../repository/app_repository.dart';

/**
 * Created by Abdullah on 13/10/24.
 */


class AppRepositoryImpl extends AppRepository{
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





}