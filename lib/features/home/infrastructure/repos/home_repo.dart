import 'package:dio/dio.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../../../core/infrastructure/network/network_info.dart';
import '../../../../core/presentation/utils/riverpod_framework.dart';
import '../../domain/article.dart';
import '../data_sources/home_remote_data_source.dart';

part 'home_repo.g.dart';

@Riverpod(keepAlive: true)
HomeRepo homeRepo(HomeRepoRef ref) {
  return HomeRepo(
    networkInfo: ref.watch(networkInfoProvider),
    remoteDataSource: ref.watch(homeRemoteDataSourceProvider),
  );
}

class HomeRepo {
  HomeRepo({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  final NetworkInfo networkInfo;
  final HomeRemoteDataSource remoteDataSource;

  Future<Articles> fetchArticles({CancelToken? cancelToken}) async {
    final nextWebArticles = await remoteDataSource.fetchNextWebArticles(cancelToken: cancelToken);
    final associatedPressArticles =
        await remoteDataSource.fetchAssociatedPressArticles(cancelToken: cancelToken);
    return Articles(
      items: nextWebArticles.articles
          .map((a) => a.toDomain())
          .followedBy(associatedPressArticles.articles.map((a) => a.toDomain()))
          .toIList(),
    );
  }
}
