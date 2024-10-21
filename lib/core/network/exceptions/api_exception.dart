import 'base_api_exception.dart';

/**
 * Created by Abdullah on 12/10/24.
 */


class ApiException extends BaseApiException {
  ApiException({
    required int httpCode,
    required String status,
    String message = "",
  }) : super(httpCode: httpCode, status: status, message: message);
}