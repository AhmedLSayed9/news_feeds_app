import 'package:flutter/material.dart';

import '../../../../../core/presentation/helpers/localization_helper.dart';
import '../../../../../core/presentation/styles/styles.dart';
import '../../../../../core/presentation/utils/riverpod_framework.dart';
import '../../../../../core/presentation/widgets/custom_appbar.dart';
import '../../../../../core/presentation/widgets/platform_widgets/platform_appbar.dart';
import '../../../../../gen/my_assets.dart';

class HomeScreenCompact extends ConsumerWidget {
  const HomeScreenCompact({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: PlatformAppBar(
        appbar: CustomAppBar(
          hasMenuButton: true,
          title: Text(
            tr(context).linkDevelopment.toUpperCase(),
            style: TextStyles.appBarTitle(context),
          ),
          trailingActions: [
            Container(
              width: Sizes.appBarLeadingWidth,
              alignment: Alignment.center,
              child: Image.asset(
                MyAssets.ASSETS_ICONS_SEARCH_PNG,
                fit: BoxFit.contain,
                height: 28,
                width: 28,
              ),
            ),
          ],
        ),
      ),
      body: Container(),
    );
  }
}
