import 'package:flutter/material.dart';

import '../../../../core/core_features/theme/presentation/utils/custom_colors.dart';
import '../../../../core/presentation/styles/styles.dart';
import '../../../../core/presentation/widgets/custom_shimmer.dart';
import '../../../../core/presentation/widgets/seperated_sliver_child_builder_delegate.dart';
import '../../domain/article.dart';
import 'article_item.dart';

class ArticlesList extends StatelessWidget {
  const ArticlesList({
    required this.articles,
    required this.isShimmer,
    super.key,
  });

  final Articles articles;
  final bool isShimmer;

  static const cardRadius = 2.0;

  static BoxDecoration cardDecoration(BuildContext context) => BoxDecoration(
        borderRadius: BorderRadius.circular(cardRadius),
        color: customColors(context).whiteColor,
      );

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(
        top: Sizes.screenPaddingV24,
        bottom: Sizes.screenPaddingV24 + Sizes.homeIndicatorHeight,
        right: Sizes.screenPaddingH24,
        left: Sizes.screenPaddingH24,
      ),
      sliver: SliverList(
        delegate: SeparatedSliverChildBuilderDelegate(
          itemCount: articles.items.length,
          itemBuilder: (BuildContext context, int index) {
            return isShimmer
                ? CustomShimmerContainer(
                    borderRadius: cardDecoration(context).borderRadius,
                    child: ArticleItem(article: articles.items[index]),
                  )
                : ArticleItem(article: articles.items[index]);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: Sizes.marginV20);
          },
        ),
      ),
    );
  }
}
