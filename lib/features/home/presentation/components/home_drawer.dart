import 'package:flutter/material.dart';

import '../../../../core/core_features/theme/presentation/utils/custom_colors.dart';
import '../../../../core/presentation/helpers/localization_helper.dart';
import '../../../../core/presentation/styles/styles.dart';
import '../../../../gen/my_assets.dart';
import 'home_drawer_dialog.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  static const itemsVGap = SizedBox(
    height: Sizes.marginV4,
  );

  @override
  Widget build(BuildContext context) {
    void closeDrawer(String sectionName) {
      if (Scaffold.of(context).isDrawerOpen) {
        Scaffold.of(context).openEndDrawer();
      }
      showSectionDialog(context, sectionName);
    }

    return SizedBox(
      width: Sizes.drawerWidth280,
      child: Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.drawerPaddingV88,
            ),
            child: Column(
              children: [
                const HomeDrawerHeader(),
                const SizedBox(
                  height: Sizes.marginV28,
                ),
                DrawerItem(
                  title: tr(context).explore,
                  icon: MyAssets.ASSETS_ICONS_MENU_ICONS_EXPLORE_PNG,
                  onTap: () => closeDrawer(tr(context).explore),
                ),
                itemsVGap,
                DrawerItem(
                  title: tr(context).liveChat,
                  icon: MyAssets.ASSETS_ICONS_MENU_ICONS_LIVE_PNG,
                  onTap: () => closeDrawer(tr(context).liveChat),
                ),
                itemsVGap,
                DrawerItem(
                  title: tr(context).gallery,
                  icon: MyAssets.ASSETS_ICONS_MENU_ICONS_GALLERY_PNG,
                  onTap: () => closeDrawer(tr(context).gallery),
                ),
                itemsVGap,
                DrawerItem(
                  title: tr(context).wishList,
                  icon: MyAssets.ASSETS_ICONS_MENU_ICONS_WISHLIST_PNG,
                  onTap: () => closeDrawer(tr(context).wishList),
                ),
                itemsVGap,
                DrawerItem(
                  title: tr(context).eMagazine,
                  icon: MyAssets.ASSETS_ICONS_MENU_ICONS_E_MAGAZINE_PNG,
                  onTap: () => closeDrawer(tr(context).eMagazine),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    required this.title,
    required this.icon,
    required this.onTap,
    super.key,
  });
  final String title;
  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        icon,
        width: Sizes.icon24,
      ),
      title: Text(
        title,
        style: TextStyles.f18(context).copyWith(),
      ),
      onTap: onTap,
      dense: true,
      horizontalTitleGap: 0,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: Sizes.drawerPaddingH40,
        vertical: 8,
      ),
    );
  }
}

class HomeDrawerHeader extends StatelessWidget {
  const HomeDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingH32),
      child: Row(
        children: [
          Flexible(
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 32,
                  backgroundImage: AssetImage(MyAssets.ASSETS_ICONS_MENU_ICONS_PROFILE_PNG),
                ),
                const SizedBox(width: Sizes.marginH20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr(context).welcome,
                        style: TextStyle(
                          color: customColors(context).font16Color?.withOpacity(0.5),
                        ),
                      ),
                      Text(
                        'Tony Roshdy',
                        style: TextStyles.f16(context),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: Sizes.marginH20),
          Image.asset(
            MyAssets.ASSETS_ICONS_MENU_ICONS_ARROW_PNG,
            height: Sizes.icon32,
            width: Sizes.icon32,
          ),
        ],
      ),
    );
  }
}
