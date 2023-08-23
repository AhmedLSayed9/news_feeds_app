import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../gen/my_assets.dart';
import '../../providers/splash_providers.dart';
import '../../routing/app_router.dart';
import '../../utils/riverpod_framework.dart';
import '../../widgets/responsive_widgets/responsive_layouts.dart';
import 'splash_screen_compact.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  static Future<void> precacheAssets(BuildContext context) async {
    await precacheImage(
      const AssetImage(MyAssets.ASSETS_IMAGES_CORE_SPLASH_ICON_PNG),
      context,
    );
  }

  static const setOlderAndroidImmersiveMode = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isWarmedUp = !ref.isLoading(splashServicesWarmupProvider);
    if (isWarmedUp) {
      ref.listen<AsyncValue<String>>(
        splashTargetProvider,
        (prevState, newState) {
          late String nextRoute;
          newState.whenOrNull(
            data: (next) => nextRoute = next,
            error: (e, st) => nextRoute = const HomeRoute().location,
          );
          context.go(nextRoute);
        },
      );
    }

    return WindowClassLayout(
      compact: (_) => OrientationLayout(
        portrait: (_) => const SplashScreenCompact(),
      ),
    );
  }
}
