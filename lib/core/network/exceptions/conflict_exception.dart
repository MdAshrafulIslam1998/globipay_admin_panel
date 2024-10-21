import 'package:universal_io/io.dart';

import 'base_api_exception.dart';

/**
 * Created by Abdullah on 12/10/24.
 */

class ConflictException extends BaseApiException {
  ConflictException(String message)
      : super(
      httpCode: HttpStatus.conflict,
      message: message,
      status: "conflict");
}