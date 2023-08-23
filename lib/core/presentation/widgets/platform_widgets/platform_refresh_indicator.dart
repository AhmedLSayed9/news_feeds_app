import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core_features/theme/presentation/utils/custom_colors.dart';
import 'platform_base_widget.dart';

class PlatformRefreshIndicator extends PlatformBaseWidget<RefreshIndicator, CustomScrollView> {
  const PlatformRefreshIndicator({
    required this.onRefresh,
    required this.slivers,
    super.key,
    this.widgetKey,
    this.scrollController,
    this.cacheExtent,
    this.topPadding = 0.0,
  });

  final Key? widgetKey;
  final ScrollController? scrollController;
  final double? cacheExtent;
  final Future<void> Function() onRefresh;
  final List<Widget> slivers;
  final double topPadding;

  EdgeInsets get _padding => EdgeInsets.only(top: topPadding);

  @override
  RefreshIndicator createMaterialWidget(BuildContext context) {
    return RefreshIndicator(
      key: widgetKey,
      edgeOffset: topPadding,
      onRefresh: onRefresh,
      color: customColors(context).loadingIndicatorColor,
      child: CustomScrollView(
        cacheExtent: cacheExtent,
        controller: scrollController,
        slivers: [
          SliverPadding(padding: _padding),
          ...slivers,
        ],
      ),
    );
  }

  @override
  CustomScrollView createCupertinoWidget(BuildContext context) {
    return CustomScrollView(
      key: widgetKey,
      controller: scrollController,
      cacheExtent: cacheExtent,
      slivers: [
        // Using SliverPadding as SliverToBoxAdapter somehow hides the refresh indicator.
        SliverPadding(
          padding: _padding,
          sliver: CupertinoSliverRefreshControl(
            onRefresh: onRefresh,
          ),
        ),
        ...slivers,
      ],
    );
  }
}
