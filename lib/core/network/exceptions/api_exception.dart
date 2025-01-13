import 'base_api_exception.dart';

/// Created by Abdullah on 12/10/24.


class ApiException extends BaseApiException {
  ApiException({
    required super.httpCode,
    required super.status,
    super.message,
  });
}