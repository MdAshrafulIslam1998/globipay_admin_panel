import 'base_exception.dart';

/**
 * Created by Abdullah on 12/10/24.
 */

class AppException extends BaseException {
  AppException({
    String message = "",
  }) : super(message: message);
}