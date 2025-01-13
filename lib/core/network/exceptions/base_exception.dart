/// Created by Abdullah on 12/10/24.
library;


abstract class BaseException implements Exception {
  final String message;

  BaseException({this.message = ""});
}