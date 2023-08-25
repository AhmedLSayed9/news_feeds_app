// ignore_for_file: avoid_redundant_argument_values

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_feeds_app/core/infrastructure/network/main_api/api_callers/main_api_facade.dart';
import 'package:news_feeds_app/core/infrastructure/network/main_api/main_api_config.dart';
import 'package:news_feeds_app/core/presentation/utils/riverpod_framework.dart';
import 'package:news_feeds_app/features/home/infrastructure/data_sources/home_remote_data_source.dart';
import 'package:news_feeds_app/features/home/infrastructure/dtos/article_dto.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../utils/utils.dart';

class MockMainApiFacade extends Mock implements MainApiFacade {}

void main() {
  late MockMainApiFacade mockMainApiFacade;

  setUpAll(() {
    registerFallbackValue(Options());
  });

  setUp(() {
    mockMainApiFacade = MockMainApiFacade();
  });

  ProviderContainer setUpRemoteContainer() {
    return setUpContainer(
      overrides: [
        mainApiFacadeProvider.overrideWithValue(mockMainApiFacade),
      ],
    );
  }

  void setUpMockNetworkSuccessfulGet({required Map<String, dynamic>? responseData}) {
    when(
      () => mockMainApiFacade.getData<Map<String, dynamic>>(
        path: any(named: 'path'),
        queryParameters: any(named: 'queryParameters'),
        options: any(named: 'options'),
        cancelToken: any(named: 'cancelToken'),
      ),
    ).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: ''),
        data: responseData,
        statusCode: 200,
      ),
    );
  }

  group(
    'fetchNextWebArticles',
    () {
      final tResponseMap =
          json.decode(fixtureReader('home/next_web_articles.json')) as Map<String, dynamic>;
      final tArticlesDto = ArticlesDto.fromJson(tResponseMap);
      test(
        'should call mainApiFacade.getData with the proper params and return the proper remote data '
        'when the response is successful',
        () async {
          // GIVEN
          setUpMockNetworkSuccessfulGet(responseData: tResponseMap);

          final container = setUpRemoteContainer();

          // WHEN
          final remoteDataSource = container.read(homeRemoteDataSourceProvider);
          final result = await remoteDataSource.fetchNextWebArticles(cancelToken: null);

          // THEN
          verifyOnly(
            mockMainApiFacade,
            () => mockMainApiFacade.getData<Map<String, dynamic>>(
              path: HomeRemoteDataSource.articlesPath,
              queryParameters: HomeRemoteDataSource.nextWebArticlesParams,
              options: any(
                named: 'options',
                that: isA<Options>().having(
                  (e) => e.extra,
                  'extra',
                  equals({MainApiConfig.apiKeyExtraKey: true}),
                ),
              ),
              cancelToken: null,
            ),
          );
          expect(result, equals(tArticlesDto));
        },
      );
      //Testing of throwing ServerException when the response is unsuccessful
      //is already done at the mainApiCaller test
    },
  );

  group(
    'fetchAssociatedPressArticles',
    () {
      final tResponseMap =
          json.decode(fixtureReader('home/associated_articles.json')) as Map<String, dynamic>;
      final tArticlesDto = ArticlesDto.fromJson(tResponseMap);
      test(
        'should call mainApiFacade.getData with the proper params and return the proper remote data '
        'when the response is successful',
        () async {
          // GIVEN
          setUpMockNetworkSuccessfulGet(responseData: tResponseMap);

          final container = setUpRemoteContainer();

          // WHEN
          final remoteDataSource = container.read(homeRemoteDataSourceProvider);
          final result = await remoteDataSource.fetchAssociatedPressArticles(cancelToken: null);

          // THEN
          verifyOnly(
            mockMainApiFacade,
            () => mockMainApiFacade.getData<Map<String, dynamic>>(
              path: HomeRemoteDataSource.articlesPath,
              queryParameters: HomeRemoteDataSource.associatedPressArticlesParams,
              options: any(
                named: 'options',
                that: isA<Options>().having(
                  (e) => e.extra,
                  'extra',
                  equals({MainApiConfig.apiKeyExtraKey: true}),
                ),
              ),
              cancelToken: null,
            ),
          );
          expect(result, equals(tArticlesDto));
        },
      );
    },
  );
}
