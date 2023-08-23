import 'package:flutter/material.dart';

import '../../core_features/theme/presentation/utils/app_static_colors.dart';
import '../routing/navigation_service.dart';
import '../styles/styles.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    this.title,
    this.centerTitle = false,
    this.hasBackButton = false,
    this.result,
    this.hasMenuButton = false,
    this.scaffoldKey,
    this.trailingActions,
    this.appBarPadding = EdgeInsets.zero,
    this.backgroundColor,
    this.statusBarColor,
    super.key,
  });

  final Widget? title;
  final bool centerTitle;
  final bool hasBackButton;
  final Object? result;
  final bool hasMenuButton;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final List<Widget>? trailingActions;
  final EdgeInsetsGeometry? appBarPadding;
  final Color? backgroundColor;
  final Color? statusBarColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? Theme.of(context).appBarTheme.backgroundColor,
      padding: appBarPadding,
      child: AppBar(
        leading: hasBackButton
            ? CustomBackButton(result: result)
            : hasMenuButton
                ? const CustomMenuButton()
                : null,
        leadingWidth: Sizes.appBarLeadingWidth,
        automaticallyImplyLeading: false,
        title: title,
        centerTitle: centerTitle,
        titleSpacing: 20,
        actions: trailingActions,
        backgroundColor: backgroundColor,
        systemOverlayStyle: Theme.of(context)
            .appBarTheme
            .systemOverlayStyle
            ?.copyWith(statusBarColor: statusBarColor),
      ),
    );
  }
}

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    required this.result,
    super.key,
  });
  final dynamic result;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: BackButton(
        color: AppStaticColors.white,
        onPressed: () => NavigationService.pop(context, result: result),
      ),
    );
  }
}

class CustomMenuButton extends StatelessWidget {
  const CustomMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      icon: const Icon(
        Icons.menu_rounded,
        color: AppStaticColors.white,
        size: Sizes.appBarButtonR32,
      ),
      constraints: const BoxConstraints(),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }
}
