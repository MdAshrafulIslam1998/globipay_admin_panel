import 'package:universal_io/io.dart';

import 'base_api_exception.dart';

/**
 * Created by Abdullah on 12/10/24.
 */

class ServiceUnavailableException extends BaseApiException {
  ServiceUnavailableException(String message)
      : super(
      httpCode: HttpStatus.serviceUnavailable,
      message: message,
      status: "");
}