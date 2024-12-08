import 'package:globipay_admin_panel/core/base/base_remote_source.dart';
import 'package:globipay_admin_panel/core/data/model/pagination_request.dart';
import 'package:globipay_admin_panel/data/api/app_api.dart';
import 'package:globipay_admin_panel/entity/request/login/login_request.dart';
import 'package:globipay_admin_panel/entity/response/login/login_response.dart';
import 'package:globipay_admin_panel/entity/response/user_response/user_response_entity.dart';

import '../../../flavors/flavor_config.dart';
import 'app_remote_data_source.dart';

/**
 * Created by Abdullah on 13/10/24.
 */

class AppRemoteDataSourceImpl extends BaseRemoteSource
    implements AppRemoteDataSource {
  final String BASE_URL = FlavorConfig.instance.url;

  @override
  Future<UserResponseEntity> requestForUserList(PaginationRequest request, {String? path}) {
    var endpoint = '$BASE_URL/${path ?? AppApi.userVerifiedProfile}';
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

}
