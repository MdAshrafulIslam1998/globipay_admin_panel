import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:globipay_admin_panel/core/network/exceptions/api_exception.dart';
import 'package:globipay_admin_panel/core/network/exceptions/app_exception.dart';
import 'package:globipay_admin_panel/core/network/exceptions/bad_request_exception.dart';
import 'package:globipay_admin_panel/core/network/exceptions/conflict_exception.dart';
import 'package:globipay_admin_panel/core/network/exceptions/network_exception.dart';
import 'package:globipay_admin_panel/core/network/exceptions/not_found_exception.dart';
import 'package:globipay_admin_panel/core/network/exceptions/timeout_exception.dart';
import 'package:globipay_admin_panel/core/network/exceptions/unauthorize_exception.dart';
import 'package:globipay_admin_panel/core/widgets/app_print.dart';

import 'exceptions/service_unavailable_exception.dart';

/**
 * Created by Abdullah on 12/10/24.
 */

Exception handleError(String error) {
  appPrint(tag: "Generic Exception", error);

  return AppException(message: error);
}

Exception handleDioError(DioException dioError) {
  switch (dioError.type) {
    case DioExceptionType.cancel:
      return AppException(
          message: "Request to API server was cancelled");
    case DioExceptionType.connectionTimeout:
      return AppException(
          message: "Connection timeout with API server");
    case DioExceptionType.unknown:
      return NetworkException("Something went wrong. Please try again later");
    case DioExceptionType.receiveTimeout:
      return TimeoutException(
          "Receive timeout in connection with API server");
    case DioExceptionType.sendTimeout:
      return TimeoutException("Send timeout in connection with API server");
    case DioExceptionType.badResponse:
      return _parseDioErrorResponse(dioError);
    case DioExceptionType.badCertificate:
      return NetworkException("Bad certificate");
    case DioExceptionType.connectionError:
      return NetworkException("Connection error");
  }
}

Exception _parseDioErrorResponse(DioError dioError) {
  int statusCode = dioError.response?.statusCode ?? -1;
  String? status;
  String? serverMessage;

  try {
    if (statusCode == -1 || statusCode == HttpStatus.ok) {
      statusCode = dioError.response?.data["responseCode"];
    }
    serverMessage = dioError.response?.data["responseMessage"];
    status = dioError.response?.data["status"];
  } catch (e, s) {
    appPrint(e);
    appPrint(s.toString());

    serverMessage = "Something went wrong. Please try again later";
  }

  switch (statusCode) {
    case HttpStatus.serviceUnavailable:
      return ServiceUnavailableException("Service Temporarily Unavailable");
    case HttpStatus.notFound:
      return NotFoundException(serverMessage ?? "", status ?? "");
    case HttpStatus.badRequest:
      return BadRequestException(serverMessage ?? "");
    case HttpStatus.unauthorized:
      return UnauthorizedException(serverMessage ?? "");
    case HttpStatus.conflict:
      return ConflictException(serverMessage ?? "");
    default:
      return ApiException(
          httpCode: statusCode,
          status: status ?? "",
          message:
          "Something went wrong. Please try again later");
  }
}