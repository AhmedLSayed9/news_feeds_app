import 'dart:convert';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_feeds_app/core/infrastructure/services/cache_service.dart';
import 'package:news_feeds_app/core/infrastructure/services/connection_stream_service.dart';
import 'package:news_feeds_app/core/presentation/helpers/localization_helper.dart';
import 'package:news_feeds_app/core/presentation/utils/riverpod_framework.dart';
import 'package:news_feeds_app/core/presentation/widgets/custom_appbar.dart';
import 'package:news_feeds_app/core/presentation/widgets/custom_elevated_button.dart';
import 'package:news_feeds_app/core/presentation/widgets/custom_shimmer.dart';
import 'package:news_feeds_app/core/presentation/widgets/platform_widgets/platform_appbar.dart';
import 'package:news_feeds_app/features/home/domain/article.dart';
import 'package:news_feeds_app/features/home/infrastructure/dtos/article_dto.dart';
import 'package:news_feeds_app/features/home/presentation/components/home_drawer.dart';
import 'package:news_feeds_app/features/home/presentation/providers/articles_provider.dart';
import 'package:news_feeds_app/features/home/presentation/screens/home_screen/home_screen_compact.dart';

import '../../../../../fixtures/fixture_reader.dart';
import '../../../../../utils/utils.dart';

void main() {
  late MockCacheManager mockCacheManager;

  setUpAll(() {
    mockCacheManager = MockCacheManager();
  });

  Future<void> pumpHomeScreenCompact(
    WidgetTester tester,
    List<Override> overrides, {
    ConsumerCallBack? initState,
  }) async {
    await tester.pumpRiverpodApp(
      const HomeScreenCompact(),
      initState: initState,
      overrides: [
        cacheServiceProvider.overrideWithValue(CacheService(customCacheManager: mockCacheManager)),
        connectionStreamProvider.overrideWith((ref) => throw UnimplementedError()),
        ...overrides,
      ],
    );
  }

  final homeScreen = find.byType(HomeScreenCompact);
  final appBar = find.byType(PlatformAppBar);
  final customAppBar = find.descendant(of: appBar, matching: find.byType(CustomAppBar));
  final menuButton = find.descendant(of: customAppBar, matching: find.byType(CustomMenuButton));
  final drawer = find.byType(HomeDrawer);

  final tResponseMap =
      json.decode(fixtureReader('home/associated_articles.json')) as Map<String, dynamic>;
  final tArticles = ArticlesDto.fromJson(tResponseMap).toDomain();
  final tEmptyArticles = Articles(items: IList(const []));
  final loadingWidget = find.byType(CustomShimmerContainer, skipOffstage: false);

  runGoldenTests(
    'should display home appbar and open drawer when pressing the menu button',
    (WidgetTester tester, ViewVariant variant) async {
      // GIVEN
      await pumpHomeScreenCompact(
        tester,
        [articlesProvider.overrideWith((ref) => tArticles)],
      );

      // THEN
      expect(appBar, findsOneWidget);
      expect(customAppBar, findsOneWidget);
      expect(menuButton, findsOneWidget);

      await tester.tap(menuButton);
      await tester.pumpAndSettle();

      expect(drawer, findsOneWidget);
      await tester.verifyGolden(drawer, 'goldens/${variant.name}_drawer.png');
    },
  );

  runGoldenTests(
    'should display articles list when articlesProvider returns data',
    (WidgetTester tester, ViewVariant variant) async {
      // GIVEN
      late final WidgetRef ref;
      final dep = AsyncNotifierProvider<TestAsyncNotifier<Articles>, Articles>(
        () => TestAsyncNotifier((ref) async => tArticles),
      );
      await pumpHomeScreenCompact(
        tester,
        [articlesProvider.overrideWith((ref) => ref.watch(dep.future))],
        initState: (_, r) => ref = r,
      );

      // THEN
      expect(loadingWidget, findsWidgets);

      await tester.pumpAndSettle();

      for (final article in tArticles.items) {
        expect(
          find.byKey(ValueKey(article.publishDate), skipOffstage: false),
          findsOneWidget,
        );
      }
      await tester.verifyGolden(homeScreen, 'goldens/${variant.name}_articles.png');

      // GIVEN
      ref.read(dep.notifier).state = AsyncData(tEmptyArticles);
      final BuildContext context = tester.element(homeScreen);

      // THEN
      await tester.pumpAndSettle();
      expect(find.text(tr(context).noArticlesFound), findsOneWidget);
      await tester.verifyGolden(homeScreen, 'goldens/${variant.name}_articles_empty.png');
    },
  );

  runGoldenTests(
    'should display retry button when articlesProvider returns error',
    (WidgetTester tester, ViewVariant variant) async {
      // GIVEN
      late final WidgetRef ref;
      final dep = AsyncNotifierProvider<TestAsyncNotifier<Articles>, Articles>(
        () => TestAsyncNotifier((ref) async => throw Exception('error occurred!')),
      );
      await pumpHomeScreenCompact(
        tester,
        [articlesProvider.overrideWith((ref) => ref.watch(dep.future))],
        initState: (_, r) => ref = r,
      );
      final BuildContext context = tester.element(homeScreen);

      // THEN
      expect(loadingWidget, findsWidgets);

      await tester.pumpAndSettle();

      final retryText = find.text(tr(context).retry);
      final retryButton = find.ancestor(of: retryText, matching: find.byType(CustomElevatedButton));
      expect(retryButton, findsOneWidget);
      await tester.verifyGolden(homeScreen, 'goldens/${variant.name}_articles_error.png');

      // WHEN
      await tester.tap(retryButton);
      await tester.pump();

      // THEN
      expect(loadingWidget, findsWidgets);

      ref.read(dep.notifier).state = AsyncData(tEmptyArticles);

      await tester.pumpAndSettle();
      expect(find.text(tr(context).noArticlesFound), findsOneWidget);
    },
  );
}
