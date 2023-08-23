// ignore_for_file: avoid_redundant_argument_values, invalid_use_of_protected_member, avoid_dynamic_calls

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_feeds_app/core/infrastructure/network/main_api/interceptors/error_interceptor.dart';

class MockErrorInterceptorHandler extends Mock implements ErrorInterceptorHandler {}

class MockDioException extends Mock implements DioException {}

void main() {
  late MockErrorInterceptorHandler mockErrorInterceptorHandler;
  late ErrorInterceptor errorInterceptor;

  setUpAll(() {
    registerFallbackValue(MockDioException());
  });

  setUp(() {
    mockErrorInterceptorHandler = MockErrorInterceptorHandler();
    errorInterceptor = ErrorInterceptor();
  });

  group('onError', () {
    const tErrorMessage = 'error_message_test';
    const tErrorType = DioExceptionType.badResponse;

    test(
      'should call handler.next if response.statusCode is not determined',
      () async {
        // GIVEN
        final tError = DioException(
          response: Response(
            requestOptions: RequestOptions(path: ''),
            data: {'message': tErrorMessage},
            statusCode: 500,
          ),
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.unknown,
        );
        // WHEN
        await errorInterceptor.onError(tError, mockErrorInterceptorHandler);
        // THEN
        verify(() => mockErrorInterceptorHandler.next(tError)).called(1);
        verifyNoMoreInteractions(mockErrorInterceptorHandler);
      },
    );

    test(
      'should override DioError message with error message from backend '
      'and override DioError type with DioExceptionType.badResponse if response.statusCode is 400',
      () async {
        // GIVEN
        final tError = DioException(
          response: Response(
            requestOptions: RequestOptions(path: ''),
            data: {'message': tErrorMessage},
            statusCode: 400,
          ),
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.unknown,
        );
        // THEN
        try {
          await errorInterceptor.onError(tError, mockErrorInterceptorHandler);
        } catch (e) {
          // need to cast it as the type is private in dio
          final exception = (e as dynamic).data;
          expect(exception, isA<DioException>());
          final dioException = exception as DioException;
          expect(dioException.error, tErrorMessage);
          expect(dioException.type, tErrorType);
          expect(dioException.response!.statusCode, 400);

          verify(() => mockErrorInterceptorHandler.reject(tError)).called(1);
          verifyNoMoreInteractions(mockErrorInterceptorHandler);
        }
      },
    );
  });
}
