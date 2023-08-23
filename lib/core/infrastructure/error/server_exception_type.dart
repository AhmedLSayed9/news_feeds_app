part of 'app_exception.dart';

enum ServerExceptionType {
  general, //Used for Business Logic errors
  unauthorized,
  forbidden,
  notFound,
  conflict,
  internal,
  serviceUnavailable,
  timeOut,
  noInternet,
  unknown,
}
