part of '../app_router.dart';

@TypedGoRoute<HomeRoute>(
  path: '/home',
  routes: [
    TypedGoRoute<ArticleDetailsRoute>(path: 'article_details/:articleIndex'),
  ],
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      FadeTransitionPage(state.pageKey, const HomeScreen());
}

class ArticleDetailsRoute extends GoRouteData {
  const ArticleDetailsRoute(this.articleIndex);

  final int articleIndex;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ArticleDetailsScreen(articleIndex: articleIndex);
}
