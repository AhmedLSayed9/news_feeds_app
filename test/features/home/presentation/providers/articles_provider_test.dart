import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_feeds_app/core/presentation/utils/riverpod_framework.dart';
import 'package:news_feeds_app/features/home/domain/article.dart';
import 'package:news_feeds_app/features/home/infrastructure/dtos/article_dto.dart';
import 'package:news_feeds_app/features/home/infrastructure/repos/home_repo.dart';
import 'package:news_feeds_app/features/home/presentation/providers/articles_provider.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../utils/utils.dart';

class MockHomeRepo extends Mock implements HomeRepo {}

void main() {
  late MockHomeRepo mockHomeRepo;

  setUp(() {
    mockHomeRepo = MockHomeRepo();
  });

  ProviderContainer setUpRepoContainer() {
    return setUpContainer(
      overrides: [
        homeRepoProvider.overrideWithValue(mockHomeRepo),
      ],
    );
  }

  final tResponseMap =
      json.decode(fixtureReader('home/associated_articles.json')) as Map<String, dynamic>;
  final tArticles = ArticlesDto.fromJson(tResponseMap).toDomain();

  final tException = Exception('test_exception');
  final tStackTrace = StackTrace.current;

  const loadingState = AsyncLoading<Articles>();
  final dataState = AsyncData<Articles>(tArticles);
  final errorState = AsyncError<Articles>(tException, tStackTrace);

  group(
    'articlesProvider',
    () {
      test(
        'should emit dataState when HomeRepo.fetchArticles returns normally',
        () async {
          // GIVEN
          when(() => mockHomeRepo.fetchArticles(cancelToken: any(named: 'cancelToken')))
              .thenAnswer((_) async => tArticles);

          final container = setUpRepoContainer();
          final listener = setUpListener(container, articlesProvider);

          // WHEN
          verifyOnly(listener, () => listener(null, loadingState));

          final call = container.read(articlesProvider.future);

          // THEN
          await expectLater(call, completion(tArticles));

          verifyInOrder([
            () => mockHomeRepo.fetchArticles(cancelToken: any(named: 'cancelToken')),
            () => listener(loadingState, dataState),
          ]);
          verifyNoMoreInteractions(mockHomeRepo);
          verifyNoMoreInteractions(listener);
        },
      );
      test(
        'should emit errorState when HomeRepo.fetchArticles throws',
        () async {
          // GIVEN
          when(() => mockHomeRepo.fetchArticles(cancelToken: any(named: 'cancelToken'))).thenAnswer(
            (_) async => Error.throwWithStackTrace(tException, tStackTrace),
          );

          final container = setUpRepoContainer();
          final listener = setUpListener(container, articlesProvider);

          // WHEN
          verifyOnly(listener, () => listener(null, loadingState));

          final call = container.read(articlesProvider.future);

          // THEN
          await expectLater(call, throwsA(tException));

          verifyInOrder([
            () => mockHomeRepo.fetchArticles(cancelToken: any(named: 'cancelToken')),
            () => listener(loadingState, errorState),
          ]);
          verifyNoMoreInteractions(mockHomeRepo);
          verifyNoMoreInteractions(listener);
        },
      );
    },
  );
}
