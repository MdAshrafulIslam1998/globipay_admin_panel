import 'package:universal_io/io.dart';
import 'base_api_exception.dart';

/// Created by Abdullah on 12/10/24.

class BadRequestException extends BaseApiException {
  BadRequestException(String message)
      : super(
      httpCode: HttpStatus.badRequest,
      message: message,
      status: "bad request");
}
