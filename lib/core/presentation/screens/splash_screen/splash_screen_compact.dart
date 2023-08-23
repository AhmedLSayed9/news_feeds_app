import 'package:flutter/material.dart';

import '../../../../gen/my_assets.dart';
import '../../../core_features/theme/presentation/utils/app_static_colors.dart';
import '../../styles/styles.dart';
import '../full_screen_scaffold.dart';
import 'splash_screen.dart';

class SplashScreenCompact extends StatelessWidget {
  const SplashScreenCompact({super.key});

  @override
  Widget build(BuildContext context) {
    return FullScreenScaffold(
      backgroundColor: AppStaticColors.pictonBlue,
      setOlderAndroidImmersiveMode: SplashScreen.setOlderAndroidImmersiveMode,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.screenPaddingH16),
        child: Center(
          child: Image.asset(
            MyAssets.ASSETS_IMAGES_CORE_SPLASH_ICON_PNG,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
