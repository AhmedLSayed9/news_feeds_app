import 'package:dio/dio.dart';

class ResponseInterceptor extends Interceptor {
  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    /* if (response.data case final Map<dynamic, dynamic> data) {
      if (data['data'] != null) {
        return handler.next(response..data = data['data']);
      }
    } */
    return handler.next(response);
  }
}
