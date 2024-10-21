import 'dart:io';
import 'base_api_exception.dart';

/**
 * Created by Abdullah on 12/10/24.
 */

class TokenException extends BaseApiException {
  TokenException(String message)
      : super(
      httpCode: HttpStatus.forbidden,
      message: message,
      status: "Token Expired");
}