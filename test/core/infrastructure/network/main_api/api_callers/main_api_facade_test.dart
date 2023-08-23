// ignore_for_file: inference_failure_on_function_invocation

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_feeds_app/core/infrastructure/network/main_api/api_callers/main_api_facade.dart';
import 'package:news_feeds_app/core/infrastructure/network/main_api/extensions/main_api_error_extension.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late MainApiFacade mainApiFacade;

  setUp(() {
    mockDio = MockDio();
    mainApiFacade = MainApiFacade(dio: mockDio);
  });

  const tPath = 'tPath';
  const tQueryParameters = <String, String>{'tQueryKey': 'tQueryValue'};
  final tData = FormData.fromMap({'tDataKey': 'tDataValue'});
  final tOptions = Options(
    headers: {'tHeaderKey': 'tHeaderValue'},
  );
  final tResponse = Response(
    requestOptions: RequestOptions(),
    data: {'tResponseKey': 'tResponseValue'},
    statusCode: 200,
  );

  final tError = DioException(
    error: 'error',
    requestOptions: RequestOptions(),
    type: DioExceptionType.badResponse,
  );

  group('getData', () {
    test(
      'should call Dio.get with the proper path/params/options',
      () async {
        // GIVEN
        when(
          () => mockDio.get(
            tPath,
            queryParameters: tQueryParameters,
            options: tOptions,
          ),
        ).thenAnswer((_) async => tResponse);
        // WHEN
        await mainApiFacade.getData(
          path: tPath,
          queryParameters: tQueryParameters,
          options: tOptions,
        );
        // THEN
        verify(
          () => mockDio.get(
            tPath,
            queryParameters: tQueryParameters,
            options: tOptions,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockDio);
      },
    );

    test(
      'should return same result from Dio.get when the response is successful',
      () async {
        // GIVEN
        when(() => mockDio.get(any())).thenAnswer((_) async => tResponse);
        // WHEN
        final result = await mainApiFacade.getData(path: tPath);
        // THEN
        expect(result, tResponse);
      },
    );

    test(
      'should throw error.mainApiErrorToServerException '
      'when the response is unsuccessful',
      () async {
        // GIVEN
        when(() => mockDio.get(any())).thenThrow(tError);
        // WHEN
        final call = mainApiFacade.getData(path: tPath);
        // THEN
        await expectLater(
          call,
          throwsA(tError.mainApiErrorToServerException()),
        );
      },
    );
  });

  group('postData', () {
    test(
      'should call Dio.post with the proper path/data/options',
      () async {
        // GIVEN
        when(
          () => mockDio.post(tPath, data: tData, options: tOptions),
        ).thenAnswer((_) async => tResponse);
        // WHEN
        await mainApiFacade.postData(
          path: tPath,
          data: tData,
          options: tOptions,
        );
        // THEN
        verify(() => mockDio.post(tPath, data: tData, options: tOptions)).called(1);
        verifyNoMoreInteractions(mockDio);
      },
    );

    test(
      'should return same result from Dio.post when the response is successful',
      () async {
        // GIVEN
        when(() => mockDio.post(any())).thenAnswer((_) async => tResponse);
        // WHEN
        final result = await mainApiFacade.postData(path: tPath);
        // THEN
        expect(result, tResponse);
      },
    );

    test(
      'should throw error.mainApiErrorToServerException '
      'when the response is unsuccessful',
      () async {
        // GIVEN
        when(() => mockDio.post(any())).thenThrow(tError);
        // WHEN
        final call = mainApiFacade.postData(path: tPath);
        // THEN
        await expectLater(
          call,
          throwsA(tError.mainApiErrorToServerException()),
        );
      },
    );
  });

  group('patchData', () {
    test(
      'should call Dio.patch with the proper path/data/options',
      () async {
        // GIVEN
        when(
          () => mockDio.patch(tPath, data: tData, options: tOptions),
        ).thenAnswer((_) async => tResponse);
        // WHEN
        await mainApiFacade.patchData(
          path: tPath,
          data: tData,
          options: tOptions,
        );
        // THEN
        verify(() => mockDio.patch(tPath, data: tData, options: tOptions)).called(1);
        verifyNoMoreInteractions(mockDio);
      },
    );

    test(
      'should return same result from Dio.patch when the response is successful',
      () async {
        // GIVEN
        when(() => mockDio.patch(any())).thenAnswer((_) async => tResponse);
        // WHEN
        final result = await mainApiFacade.patchData(path: tPath);
        // THEN
        expect(result, tResponse);
      },
    );

    test(
      'should throw error.mainApiErrorToServerException '
      'when the response is unsuccessful',
      () async {
        // GIVEN
        when(() => mockDio.patch(any())).thenThrow(tError);
        // WHEN
        final call = mainApiFacade.patchData(path: tPath);
        // THEN
        await expectLater(
          call,
          throwsA(tError.mainApiErrorToServerException()),
        );
      },
    );
  });

  group('putData', () {
    test(
      'should call Dio.put with the proper path/data/options',
      () async {
        // GIVEN
        when(
          () => mockDio.put(tPath, data: tData, options: tOptions),
        ).thenAnswer((_) async => tResponse);
        // WHEN
        await mainApiFacade.putData(
          path: tPath,
          data: tData,
          options: tOptions,
        );
        // THEN
        verify(() => mockDio.put(tPath, data: tData, options: tOptions)).called(1);
        verifyNoMoreInteractions(mockDio);
      },
    );

    test(
      'should return same result from Dio.put when the response is successful',
      () async {
        // GIVEN
        when(() => mockDio.put(any())).thenAnswer((_) async => tResponse);
        // WHEN
        final result = await mainApiFacade.putData(path: tPath);
        // THEN
        expect(result, tResponse);
      },
    );

    test(
      'should throw error.mainApiErrorToServerException '
      'when the response is unsuccessful',
      () async {
        // GIVEN
        when(() => mockDio.put(any())).thenThrow(tError);
        // WHEN
        final call = mainApiFacade.putData(path: tPath);
        // THEN
        await expectLater(
          call,
          throwsA(tError.mainApiErrorToServerException()),
        );
      },
    );
  });

  group('deleteData', () {
    test(
      'should call Dio.delete with the proper path/data/options',
      () async {
        // GIVEN
        when(
          () => mockDio.delete(tPath, data: tData, options: tOptions),
        ).thenAnswer((_) async => tResponse);
        // WHEN
        await mainApiFacade.deleteData(
          path: tPath,
          data: tData,
          options: tOptions,
        );
        // THEN
        verify(() => mockDio.delete(tPath, data: tData, options: tOptions)).called(1);
        verifyNoMoreInteractions(mockDio);
      },
    );

    test(
      'should return same result from Dio.delete when the response is successful',
      () async {
        // GIVEN
        when(() => mockDio.delete(any())).thenAnswer((_) async => tResponse);
        // WHEN
        final result = await mainApiFacade.deleteData(path: tPath);
        // THEN
        expect(result, tResponse);
      },
    );

    test(
      'should throw error.mainApiErrorToServerException '
      'when the response is unsuccessful',
      () async {
        // GIVEN
        when(() => mockDio.delete(any())).thenThrow(tError);
        // WHEN
        final call = mainApiFacade.deleteData(path: tPath);
        // THEN
        await expectLater(
          call,
          throwsA(tError.mainApiErrorToServerException()),
        );
      },
    );
  });
}
