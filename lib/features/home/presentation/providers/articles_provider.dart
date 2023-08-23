import '../../../../core/presentation/providers/provider_utils.dart';
import '../../../../core/presentation/utils/riverpod_framework.dart';
import '../../domain/article.dart';
import '../../infrastructure/repos/home_repo.dart';

part 'articles_provider.g.dart';

@riverpod
Future<Articles> articles(ArticlesRef ref) {
  final cancelToken = ref.cancelToken();
  return ref.watch(homeRepoProvider).fetchArticles(cancelToken: cancelToken);
}
