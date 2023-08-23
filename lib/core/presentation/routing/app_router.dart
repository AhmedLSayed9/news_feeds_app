import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../screens/route_error_screen/route_error_screen.dart';
import '../screens/splash_screen/splash_screen.dart';
import '../utils/riverpod_framework.dart';
import 'navigation_transitions.dart';

part 'app_router.g.dart';

part 'routes/core_routes.dart';
part 'routes/home_routes.dart';

// This or other ShellRoutes keys can be used to display a child route on a different Navigator.
// i.e: use the rootNavigatorKey for a child route inside a ShellRoute
// which need to take the full screen and ignore that Shell.
// https://pub.dev/documentation/go_router/latest/go_router/ShellRoute-class.html
final _rootNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
Raw<GoRouter> goRouter(GoRouterRef ref) {
  final router = GoRouter(
    debugLogDiagnostics: true,
    restorationScopeId: 'router',
    navigatorKey: _rootNavigatorKey,
    initialLocation: const SplashRoute().location,
    routes: $appRoutes,
    redirect: (BuildContext context, GoRouterState state) {
      // Return null (no redirecting) if the user is at or heading to a legit route.
      return null;
    },
    errorBuilder: (_, state) => RouteErrorScreen(state.error),
  );

  return router;
}
