part of '../app_router.dart';

@TypedGoRoute<HomeRoute>(
  path: '/home',
  routes: [],
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      FadeTransitionPage(state.pageKey, const HomeScreen());
}
