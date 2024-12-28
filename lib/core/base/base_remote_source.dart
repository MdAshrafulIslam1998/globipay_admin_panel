import 'package:dio/dio.dart';
import 'package:globipay_admin_panel/core/network/dio_provider.dart';
import 'package:globipay_admin_panel/core/network/error_handlers.dart';
import 'package:globipay_admin_panel/core/network/exceptions/base_exception.dart';

import '../constants/enum/network_status.dart';
import '../network/exceptions/api_exception.dart';
import '../widgets/app_print.dart';
import 'base_response.dart';

/**
 * Created by Abdullah on 12/10/24.
 */

abstract class BaseRemoteSource {
  Dio get dioClient => DioProvider.dioWithHeaderToken;
  Dio get dioClientWithAuth => DioProvider.dioWithHeaderAuthenticationToken;
  Dio get dioMultipartClientWithAuth =>
      DioProvider.dioMultipartWithHeaderAuthenticationToken;
  Dio get dioMultipartClientWithoutAuth =>
      DioProvider.dioMultipartWithoutHeaderAuthenticationToken;

  Future<BaseResponse> callApiWithErrorParser<T>(
      Future<Response<T>> request,
      ) async {
    try {
      Response<T> response = await request;

      BaseResponse baseResponse = BaseResponse();

      try {
        baseResponse =
            BaseResponse.fromJson(response.data as Map<String, dynamic>);
      } catch (e) {
        appPrint(e);
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (baseResponse.responseCode == NetworkStatus.unAuthorized.code &&
            baseResponse.data != null) {
          throw ApiException(
              message: baseResponse.responseMessage ?? "",
              httpCode: response.statusCode ?? 0,
              status: baseResponse.responseCode ?? "");
        } else if (baseResponse.responseCode != NetworkStatus.success.code) {
          throw ApiException(
              message: baseResponse.responseMessage ?? "",
              httpCode: response.statusCode ?? 0,
              status: baseResponse.responseCode ?? "");
        }
      }else if (response.statusCode == 401 || response.statusCode == 403) {
        throw ApiException(
            message: baseResponse.responseMessage ?? "",
            httpCode: response.statusCode ?? 0,
            status: baseResponse.responseCode ?? "");
      }

      return baseResponse;
    } on DioException catch (dioError) {
      Exception exception = handleDioError(dioError);

      appPrint((exception as BaseException).message,
          tag: "Repository Error:  |::::::::|  $exception ");
      throw exception;
    } catch (error) {
      appPrint(error, tag: "Repository:Generic::");
      if (error is BaseException) {
        rethrow;
      }
      throw handleError("$error");
    }
  }
}