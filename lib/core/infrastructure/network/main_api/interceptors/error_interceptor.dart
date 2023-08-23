import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;

    if (statusCode == 400) {
      final data = err.response!.data as Map<dynamic, dynamic>;
      final newErr = err.copyWith(
        error: data['message'],
        type: DioExceptionType.badResponse,
      );
      return handler.reject(newErr);
    }

    return handler.next(err);
  }
}
