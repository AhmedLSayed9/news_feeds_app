import 'package:flutter/material.dart';

import '../../../../core/core_features/theme/presentation/utils/custom_colors.dart';
import '../../../../core/presentation/helpers/date_helper.dart';
import '../../../../core/presentation/helpers/localization_helper.dart';
import '../../../../core/presentation/styles/styles.dart';
import '../../../../core/presentation/widgets/cached_network_image_rounded.dart';
import '../../../../core/presentation/widgets/responsive_widgets/responsive_center.dart';
import '../../domain/article.dart';
import 'articles_list.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem({
    required this.article,
    super.key,
  });

  final Article article;

  static const _mediumVGap = SizedBox(height: Sizes.marginV12);

  static const _smallVGap = SizedBox(height: Sizes.marginV4);

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      child: Container(
        decoration: ArticlesList.cardDecoration(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImageRounded(
              imageUrl: article.image,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(ArticlesList.cardRadius),
              ),
              height: 200,
            ),
            _mediumVGap,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingH20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: TextStyles.f18(context).copyWith(
                      fontWeight: FontStyles.fontWeightNormal,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  _smallVGap,
                  Text(
                    tr(context).byAuthor(article.author),
                    style: TextStyles.f16(context).copyWith(
                      color: customColors(context).greyColor,
                      fontWeight: FontStyles.fontWeightNormal,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  _smallVGap,
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text(
                      DateHelper.convertDateTimeToShortDate(context, article.publishDate),
                      style: TextStyles.f16(context).copyWith(
                        color: customColors(context).greyColor,
                        fontWeight: FontStyles.fontWeightNormal,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            _mediumVGap,
          ],
        ),
      ),
    );
  }
}
