import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:news_feeds_app/core/infrastructure/error/app_exception.dart';
import 'package:news_feeds_app/core/presentation/extensions/app_error_extension.dart';
import 'package:news_feeds_app/core/presentation/helpers/localization_helper.dart';
import '../../../utils/utils.dart';

void main() {
  group('message', () {
    const tMessage = 'tMessage';

    testWidgets(
      'should return same result of tr(context).unknownError '
      'when AppException is CacheException',
      (WidgetTester tester) async {
        // GIVEN
        final context = await tester.setUpLocalizationsContext;
        const AppException tException = CacheException(
          type: CacheExceptionType.general,
          message: 'error',
        );
        // WHEN
        final result = tException.errorMessage(context);
        // THEN
        expect(result, tr(context).unknownError);
      },
    );

    void runServerExceptionTest({
      required BuildContext context,
      required ServerExceptionType type,
      required String expectedResult,
    }) {
      // GIVEN
      final AppException tException = ServerException(
        type: type,
        message: tMessage,
      );
      // WHEN
      final result = tException.errorMessage(context);
      // THEN
      expect(result, expectedResult);
    }

    testWidgets(
      'should return same message from server '
      'when AppException is ServerException and type is general',
      (WidgetTester tester) async {
        final context = await tester.setUpLocalizationsContext;
        runServerExceptionTest(
          context: context,
          type: ServerExceptionType.general,
          expectedResult: tMessage,
        );
      },
    );

    testWidgets(
      'should return same result of tr(context).unauthorizedError '
      'when AppException is ServerException and type is unauthorized',
      (WidgetTester tester) async {
        final context = await tester.setUpLocalizationsContext;
        runServerExceptionTest(
          context: context,
          type: ServerExceptionType.unauthorized,
          expectedResult: tr(context).unauthorizedError,
        );
      },
    );

    testWidgets(
      'should return same result of tr(context).forbiddenError '
      'when AppException is ServerException and type is forbidden',
      (WidgetTester tester) async {
        final context = await tester.setUpLocalizationsContext;
        runServerExceptionTest(
          context: context,
          type: ServerExceptionType.forbidden,
          expectedResult: tr(context).forbiddenError,
        );
      },
    );

    testWidgets(
      'should return same result of tr(context).notFoundError '
      'when AppException is ServerException and type is notFound',
      (WidgetTester tester) async {
        final context = await tester.setUpLocalizationsContext;
        runServerExceptionTest(
          context: context,
          type: ServerExceptionType.notFound,
          expectedResult: tr(context).notFoundError,
        );
      },
    );

    testWidgets(
      'should return same result of tr(context).conflictError '
      'when AppException is ServerException and type is conflict',
      (WidgetTester tester) async {
        final context = await tester.setUpLocalizationsContext;
        runServerExceptionTest(
          context: context,
          type: ServerExceptionType.conflict,
          expectedResult: tr(context).conflictError,
        );
      },
    );

    testWidgets(
      'should return same result of tr(context).internalServerError '
      'when AppException is ServerException and type is internal',
      (WidgetTester tester) async {
        final context = await tester.setUpLocalizationsContext;
        runServerExceptionTest(
          context: context,
          type: ServerExceptionType.internal,
          expectedResult: tr(context).internalError,
        );
      },
    );

    testWidgets(
      'should return same result of tr(context).serviceUnavailableError '
      'when AppException is ServerException and type is serviceUnavailable',
      (WidgetTester tester) async {
        final context = await tester.setUpLocalizationsContext;
        runServerExceptionTest(
          context: context,
          type: ServerExceptionType.serviceUnavailable,
          expectedResult: tr(context).serviceUnavailableError,
        );
      },
    );

    testWidgets(
      'should return same result of tr(context).timeoutError '
      'when AppException is ServerException and type is timeOut',
      (WidgetTester tester) async {
        final context = await tester.setUpLocalizationsContext;
        runServerExceptionTest(
          context: context,
          type: ServerExceptionType.timeOut,
          expectedResult: tr(context).timeoutError,
        );
      },
    );

    testWidgets(
      'should return same result of tr(context).noInternetError '
      'when AppException is ServerException and type is noInternet',
      (WidgetTester tester) async {
        final context = await tester.setUpLocalizationsContext;
        runServerExceptionTest(
          context: context,
          type: ServerExceptionType.noInternet,
          expectedResult: tr(context).noInternetError,
        );
      },
    );

    testWidgets(
      'should return same result of tr(context).unknownError '
      'when AppException is ServerException and type is unknown',
      (WidgetTester tester) async {
        final context = await tester.setUpLocalizationsContext;
        runServerExceptionTest(
          context: context,
          type: ServerExceptionType.unknown,
          expectedResult: tr(context).unknownError,
        );
      },
    );
  });
}
