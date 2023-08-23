abstract class MainApiConfig {
  static const String baseUrl = 'https://newsapi.org/v1';

  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 20);

  static const contentTypeHeaderKey = 'content-type';
  static const applicationJsonContentType = 'application/json';
  static const multipartFormDataContentType = 'multipart/form-data';
  static const emptyContentType = '';

  static const apiKeyExtraKey = 'api_key';
  static const apiKeyParamKey = 'apiKey';
}
