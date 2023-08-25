import 'dart:convert';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:news_feeds_app/core/presentation/utils/riverpod_framework.dart';
import 'package:news_feeds_app/features/home/domain/article.dart';
import 'package:news_feeds_app/features/home/infrastructure/data_sources/home_remote_data_source.dart';
import 'package:news_feeds_app/features/home/infrastructure/dtos/article_dto.dart';
import 'package:news_feeds_app/features/home/infrastructure/repos/home_repo.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../utils/utils.dart';

class MockHomeRemoteDataSource extends Mock implements HomeRemoteDataSource {}

void main() {
  late MockHomeRemoteDataSource mockHomeRemoteDataSource;

  setUp(() {
    mockHomeRemoteDataSource = MockHomeRemoteDataSource();
  });

  ProviderContainer setUpRemoteContainer() {
    return setUpContainer(
      overrides: [
        homeRemoteDataSourceProvider.overrideWithValue(mockHomeRemoteDataSource),
      ],
    );
  }

  final tNextWebArticlesResponseMap =
      json.decode(fixtureReader('home/next_web_articles.json')) as Map<String, dynamic>;
  final tNextWebArticlesDto = ArticlesDto.fromJson(tNextWebArticlesResponseMap);

  final tAssociatedArticlesResponseMap =
      json.decode(fixtureReader('home/associated_articles.json')) as Map<String, dynamic>;
  final tAssociatedArticlesDto = ArticlesDto.fromJson(tAssociatedArticlesResponseMap);

  final tArticles = Articles(
    items: tNextWebArticlesDto.articles
        .map((a) => a.toDomain())
        .followedBy(tAssociatedArticlesDto.articles.map((a) => a.toDomain()))
        .toIList(),
  );

  final tException = Exception('test_exception');

  group(
    'fetchArticles',
    () {
      test(
        'should return proper remote data '
        'when the call to remote data source is successful',
        () async {
          // GIVEN
          when(() => mockHomeRemoteDataSource.fetchNextWebArticles(cancelToken: null))
              .thenAnswer((_) async => tNextWebArticlesDto);
          when(() => mockHomeRemoteDataSource.fetchAssociatedPressArticles(cancelToken: null))
              .thenAnswer((_) async => tAssociatedArticlesDto);

          final container = setUpRemoteContainer();

          // WHEN
          final repo = container.read(homeRepoProvider);
          final result = await repo.fetchArticles();

          // THEN
          verifyInOrder([
            () => mockHomeRemoteDataSource.fetchNextWebArticles(cancelToken: null),
            () => mockHomeRemoteDataSource.fetchAssociatedPressArticles(cancelToken: null),
          ]);
          verifyNoMoreInteractions(mockHomeRemoteDataSource);
          expect(result, equals(tArticles));
        },
      );

      test(
        'should throw same Exception '
        'when the call to remote data source (fetchNextWebArticles) is unsuccessful',
        () async {
          // GIVEN
          when(() => mockHomeRemoteDataSource.fetchNextWebArticles(cancelToken: null))
              .thenThrow(tException);

          final container = setUpRemoteContainer();

          // WHEN
          final repo = container.read(homeRepoProvider);
          final call = repo.fetchArticles();

          // THEN
          await expectLater(call, throwsA(tException));
          verifyOnly(
            mockHomeRemoteDataSource,
            () => mockHomeRemoteDataSource.fetchNextWebArticles(cancelToken: null),
          );
        },
      );

      test(
        'should throw same Exception '
        'when the call to remote data source (fetchAssociatedPressArticles) is unsuccessful',
        () async {
          // GIVEN
          when(() => mockHomeRemoteDataSource.fetchNextWebArticles(cancelToken: null))
              .thenAnswer((_) async => tNextWebArticlesDto);
          when(() => mockHomeRemoteDataSource.fetchAssociatedPressArticles(cancelToken: null))
              .thenThrow(tException);

          final container = setUpRemoteContainer();

          // WHEN
          final repo = container.read(homeRepoProvider);
          final call = repo.fetchArticles();

          // THEN
          await expectLater(call, throwsA(tException));
          verifyInOrder([
            () => mockHomeRemoteDataSource.fetchNextWebArticles(cancelToken: null),
            () => mockHomeRemoteDataSource.fetchAssociatedPressArticles(cancelToken: null),
          ]);
          verifyNoMoreInteractions(mockHomeRemoteDataSource);
        },
      );
    },
  );
}
