import 'package:dio/dio.dart';

import '../../../../core/infrastructure/network/main_api/api_callers/main_api_facade.dart';
import '../../../../core/infrastructure/network/main_api/main_api_config.dart';
import '../../../../core/presentation/utils/riverpod_framework.dart';
import '../dtos/article_dto.dart';

part 'home_remote_data_source.g.dart';

@Riverpod(keepAlive: true)
HomeRemoteDataSource homeRemoteDataSource(HomeRemoteDataSourceRef ref) {
  return HomeRemoteDataSource(
    ref,
    mainApiFacade: ref.watch(mainApiFacadeProvider),
  );
}

class HomeRemoteDataSource {
  HomeRemoteDataSource(
    this.ref, {
    required this.mainApiFacade,
  });

  final HomeRemoteDataSourceRef ref;
  final MainApiFacade mainApiFacade;

  static String get articlesPath => 'articles';

  static Map<String, String> get nextWebArticlesParams => {'source': 'the-next-web'};
  static Map<String, String> get associatedPressArticlesParams => {'source': 'associated-press'};

  Future<ArticlesDto> fetchNextWebArticles({required CancelToken? cancelToken}) async {
    final response = await mainApiFacade.getData<Map<String, dynamic>>(
      path: articlesPath,
      queryParameters: nextWebArticlesParams,
      options: Options(
        extra: {MainApiConfig.apiKeyExtraKey: true},
      ),
      cancelToken: cancelToken,
    );
    return ArticlesDto.fromJson(response.data!);
  }

  Future<ArticlesDto> fetchAssociatedPressArticles({required CancelToken? cancelToken}) async {
    final response = await mainApiFacade.getData<Map<String, dynamic>>(
      path: articlesPath,
      queryParameters: associatedPressArticlesParams,
      options: Options(
        extra: {MainApiConfig.apiKeyExtraKey: true},
      ),
      cancelToken: cancelToken,
    );
    return ArticlesDto.fromJson(response.data!);
  }
}
