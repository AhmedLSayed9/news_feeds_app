import 'package:dio/dio.dart';

import '../main_api_config.dart';

class ContentTypeInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.data is FormData) {
      options.headers[MainApiConfig.contentTypeHeaderKey] =
          MainApiConfig.multipartFormDataContentType;
    } else if (options.data is String) {
      options.headers[MainApiConfig.contentTypeHeaderKey] =
          MainApiConfig.applicationJsonContentType;
    } else {
      options.headers[MainApiConfig.contentTypeHeaderKey] = MainApiConfig.emptyContentType;
    }

    return handler.next(options);
  }
}
