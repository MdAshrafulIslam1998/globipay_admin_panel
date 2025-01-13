import 'app_exception.dart';

/// Created by Abdullah on 12/10/24.

abstract class BaseApiException extends AppException {
  final int httpCode;
  final String status;

  BaseApiException({this.httpCode = -1, this.status = "", super.message});
}