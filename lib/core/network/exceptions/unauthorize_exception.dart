import 'dart:io';
import 'base_api_exception.dart';

/// Created by Abdullah on 12/10/24.

class UnauthorizedException extends BaseApiException {
  UnauthorizedException(String message)
      : super(
      httpCode: HttpStatus.unauthorized,
      message: message,
      status: "unauthorized");
}