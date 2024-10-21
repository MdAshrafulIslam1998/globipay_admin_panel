import 'package:universal_io/io.dart';

import 'api_exception.dart';

/**
 * Created by Abdullah on 12/10/24.
 */

class NotFoundException extends ApiException {
  NotFoundException(String message, String status)
      : super(httpCode: HttpStatus.notFound, status: status, message: message);
}