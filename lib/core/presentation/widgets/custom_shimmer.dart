import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core_features/theme/presentation/utils/app_static_colors.dart';
import 'clippers/clip_shadow.dart';
import 'clippers/rect_clipper.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppStaticColors.placeHolderBaseColor,
      highlightColor: AppStaticColors.placeHolderHighlightColor,
      direction: Directionality.of(context) == TextDirection.rtl
          ? ShimmerDirection.rtl
          : ShimmerDirection.ltr,
      child: child,
    );
  }
}

class CustomShimmerContainer extends StatelessWidget {
  const CustomShimmerContainer({
    this.height,
    this.width,
    this.child,
    BorderRadiusGeometry? borderRadius,
    this.boxShadow,
    super.key,
  }) : borderRadius = borderRadius ?? BorderRadius.zero;

  final double? height;
  final double? width;
  final Widget? child;
  final BorderRadiusGeometry borderRadius;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    final shimmer = CustomShimmer(
      child: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          color: AppStaticColors.placeHolderHighlightColor,
        ),
        child: child,
      ),
    );

    if (boxShadow != null) {
      return ClipShadow(
        clipper: RRectClipper(borderRadius: borderRadius.resolve(Directionality.of(context))),
        boxShadow: boxShadow!,
        child: shimmer,
      );
    }

    return CustomShimmer(
      child: ClipRRect(
        borderRadius: borderRadius,
        child: shimmer,
      ),
    );
  }
}
