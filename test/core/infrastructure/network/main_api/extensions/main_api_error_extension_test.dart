import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:news_feeds_app/core/infrastructure/error/app_exception.dart';
import 'package:news_feeds_app/core/infrastructure/network/main_api/extensions/main_api_error_extension.dart';

void main() {
  group('mainApiErrorToServerException', () {
    const tErrorMessage = 'test_error_message';

    test(
      'should return type ServerExceptionType.general with same message and statusCode '
      'if error type is DioExceptionType.badResponse and statusCode is 400',
      () async {
        // GIVEN
        final tError = DioException(
          error: tErrorMessage,
          response: Response(
            requestOptions: RequestOptions(),
            statusCode: 400,
          ),
          requestOptions: RequestOptions(),
          type: DioExceptionType.badResponse,
        );
        // WHEN
        final result = tError.mainApiErrorToServerException();
        // THEN
        const expectedException = ServerException(
          type: ServerExceptionType.general,
          message: tErrorMessage,
          code: 400,
        );
        expect(result.type, expectedException.type);
        expect(result.message, expectedException.message);
        expect(result.code, expectedException.code);
      },
    );

    test(
      'should return type ServerExceptionType.unauthorized with same message and statusCode '
      'if error type is DioExceptionType.badResponse and statusCode is 401',
      () async {
        // GIVEN
        final tError = DioException(
          error: tErrorMessage,
          response: Response(
            requestOptions: RequestOptions(),
            statusCode: 401,
          ),
          requestOptions: RequestOptions(),
          type: DioExceptionType.badResponse,
        );
        // WHEN
        final result = tError.mainApiErrorToServerException();
        // THEN
        const expectedException = ServerException(
          type: ServerExceptionType.unauthorized,
          message: tErrorMessage,
          code: 401,
        );
        expect(result.type, expectedException.type);
        expect(result.message, expectedException.message);
        expect(result.code, expectedException.code);
      },
    );

    test(
      'should return type ServerExceptionType.forbidden with same message and statusCode '
      'if error type is DioExceptionType.badResponse and statusCode is 403',
      () async {
        // GIVEN
        final tError = DioException(
          error: tErrorMessage,
          response: Response(
            requestOptions: RequestOptions(),
            statusCode: 403,
          ),
          requestOptions: RequestOptions(),
          type: DioExceptionType.badResponse,
        );
        // WHEN
        final result = tError.mainApiErrorToServerException();
        // THEN
        const expectedException = ServerException(
          type: ServerExceptionType.forbidden,
          message: tErrorMessage,
          code: 403,
        );
        expect(result.type, expectedException.type);
        expect(result.message, expectedException.message);
        expect(result.code, expectedException.code);
      },
    );

    void runNotFoundServerExceptionTest({required int statusCode}) {
      // GIVEN
      final tError = DioException(
        error: tErrorMessage,
        response: Response(
          requestOptions: RequestOptions(),
          statusCode: statusCode,
        ),
        requestOptions: RequestOptions(),
        type: DioExceptionType.badResponse,
      );
      // WHEN
      final result = tError.mainApiErrorToServerException();
      // THEN
      final expectedException = ServerException(
        type: ServerExceptionType.notFound,
        message: tErrorMessage,
        code: statusCode,
      );
      expect(result.type, expectedException.type);
      expect(result.message, expectedException.message);
      expect(result.code, expectedException.code);
    }

    test(
      'should return type ServerExceptionType.notFound with same message and statusCode '
      'if error type is DioExceptionType.badResponse and statusCode is 404',
      () async {
        runNotFoundServerExceptionTest(statusCode: 404);
      },
    );

    test(
      'should return type ServerExceptionType.notFound with same message and statusCode '
      'if error type is DioExceptionType.badResponse and statusCode is 405',
      () async {
        runNotFoundServerExceptionTest(statusCode: 405);
      },
    );

    test(
      'should return type ServerExceptionType.notFound with same message and statusCode '
      'if error type is DioExceptionType.badResponse and statusCode is 501',
      () async {
        runNotFoundServerExceptionTest(statusCode: 501);
      },
    );

    test(
      'should return type ServerExceptionType.conflict with same message and statusCode '
      'if error type is DioExceptionType.badResponse and statusCode is 409',
      () async {
        // GIVEN
        final tError = DioException(
          error: tErrorMessage,
          response: Response(
            requestOptions: RequestOptions(),
            statusCode: 409,
          ),
          requestOptions: RequestOptions(),
          type: DioExceptionType.badResponse,
        );
        // WHEN
        final result = tError.mainApiErrorToServerException();
        // THEN
        const expectedException = ServerException(
          type: ServerExceptionType.conflict,
          message: tErrorMessage,
          code: 409,
        );
        expect(result.type, expectedException.type);
        expect(result.message, expectedException.message);
        expect(result.code, expectedException.code);
      },
    );

    void runInternalServerExceptionTest({required int statusCode}) {
      // GIVEN
      final tError = DioException(
        error: tErrorMessage,
        response: Response(
          requestOptions: RequestOptions(),
          statusCode: statusCode,
        ),
        requestOptions: RequestOptions(),
        type: DioExceptionType.badResponse,
      );
      // WHEN
      final result = tError.mainApiErrorToServerException();
      // THEN
      final expectedException = ServerException(
        type: ServerExceptionType.internal,
        message: tErrorMessage,
        code: statusCode,
      );
      expect(result.type, expectedException.type);
      expect(result.message, expectedException.message);
      expect(result.code, expectedException.code);
    }

    test(
      'should return type ServerExceptionType.internal with same message and statusCode '
      'if error type is DioExceptionType.badResponse and statusCode is 500',
      () async {
        // GIVEN
        runInternalServerExceptionTest(statusCode: 500);
      },
    );

    test(
      'should return type ServerExceptionType.internal with same message and statusCode '
      'if error type is DioExceptionType.badResponse and statusCode is 502',
      () async {
        // GIVEN
        runInternalServerExceptionTest(statusCode: 502);
      },
    );

    test(
      'should return type ServerExceptionType.serviceUnavailable with same message and statusCode '
      'if error type is DioExceptionType.badResponse and statusCode is 503',
      () async {
        // GIVEN
        final tError = DioException(
          error: tErrorMessage,
          response: Response(
            requestOptions: RequestOptions(),
            statusCode: 503,
          ),
          requestOptions: RequestOptions(),
          type: DioExceptionType.badResponse,
        );
        // WHEN
        final result = tError.mainApiErrorToServerException();
        // THEN
        const expectedException = ServerException(
          type: ServerExceptionType.serviceUnavailable,
          message: tErrorMessage,
          code: 503,
        );
        expect(result.type, expectedException.type);
        expect(result.message, expectedException.message);
        expect(result.code, expectedException.code);
      },
    );

    test(
      'should return type ServerExceptionType.unknown with same message and statusCode '
      'if error type is DioExceptionType.badResponse and statusCode is unknown',
      () async {
        // GIVEN
        final tError = DioException(
          error: tErrorMessage,
          response: Response(
            requestOptions: RequestOptions(),
            statusCode: 0,
          ),
          requestOptions: RequestOptions(),
          type: DioExceptionType.badResponse,
        );
        // WHEN
        final result = tError.mainApiErrorToServerException();
        // THEN
        const expectedException = ServerException(
          type: ServerExceptionType.unknown,
          message: tErrorMessage,
          code: 0,
        );
        expect(result.type, expectedException.type);
        expect(result.message, expectedException.message);
        expect(result.code, expectedException.code);
      },
    );

    void runTimeOutServerExceptionTest({required DioExceptionType dioExceptionType}) {
      // GIVEN
      final tError = DioException(
        error: tErrorMessage,
        requestOptions: RequestOptions(),
        type: dioExceptionType,
      );
      // WHEN
      final result = tError.mainApiErrorToServerException();
      // THEN
      const expectedException = ServerException(
        type: ServerExceptionType.timeOut,
        message: tErrorMessage,
        code: 408,
      );
      expect(result.type, expectedException.type);
      expect(result.message, expectedException.message);
      expect(result.code, expectedException.code);
    }

    test(
      'should return type ServerExceptionType.connectTimeout with same message and statusCode 408 '
      'if error type is DioExceptionType.connectionTimeout',
      () async {
        runTimeOutServerExceptionTest(
          dioExceptionType: DioExceptionType.connectionTimeout,
        );
      },
    );

    test(
      'should return type ServerExceptionType.connectTimeout with same message and statusCode 408 '
      'if error type is DioExceptionType.sendTimeout',
      () async {
        runTimeOutServerExceptionTest(dioExceptionType: DioExceptionType.sendTimeout);
      },
    );

    test(
      'should return type ServerExceptionType.connectTimeout with same message and statusCode 408 '
      'if error type is DioExceptionType.receiveTimeout',
      () async {
        runTimeOutServerExceptionTest(
          dioExceptionType: DioExceptionType.receiveTimeout,
        );
      },
    );

    test(
      'should return type ServerExceptionType.unknown with same message and statusCode '
      'if error type is DioExceptionType.cancel',
      () async {
        // GIVEN
        final tError = DioException(
          error: tErrorMessage,
          response: Response(
            requestOptions: RequestOptions(),
            statusCode: 0,
          ),
          requestOptions: RequestOptions(),
          type: DioExceptionType.cancel,
        );
        // WHEN
        final result = tError.mainApiErrorToServerException();
        // THEN
        const expectedException = ServerException(
          type: ServerExceptionType.unknown,
          message: tErrorMessage,
          code: 0,
        );
        expect(result.type, expectedException.type);
        expect(result.message, expectedException.message);
        expect(result.code, expectedException.code);
      },
    );

    test(
      'should return type ServerExceptionType.unknown with same message and statusCode '
      'if error type is DioExceptionType.unknown',
      () async {
        // GIVEN
        final tError = DioException(
          error: tErrorMessage,
          response: Response(
            requestOptions: RequestOptions(),
            statusCode: 0,
          ),
          requestOptions: RequestOptions(),
        );
        // WHEN
        final result = tError.mainApiErrorToServerException();
        // THEN
        const expectedException = ServerException(
          type: ServerExceptionType.unknown,
          message: tErrorMessage,
          code: 0,
        );
        expect(result.type, expectedException.type);
        expect(result.message, expectedException.message);
        expect(result.code, expectedException.code);
      },
    );

    test(
      'should return type ServerExceptionType.unknown with error.toString '
      'if error is not DioException',
      () async {
        // GIVEN
        final tError = Exception(tErrorMessage);
        // WHEN
        final result = tError.mainApiErrorToServerException();
        // THEN
        final expectedException = ServerException(
          type: ServerExceptionType.unknown,
          message: tError.toString(),
        );
        expect(result.type, expectedException.type);
        expect(result.message, expectedException.message);
        expect(result.code, expectedException.code);
      },
    );
  });
}
