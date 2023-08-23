import 'package:flutter/material.dart';

import '../../../../../../core/core_features/theme/presentation/utils/custom_colors.dart';
import '../../../../../../core/presentation/styles/styles.dart';
import '../../../../../core/presentation/helpers/date_helper.dart';
import '../../../../../core/presentation/helpers/localization_helper.dart';
import '../../../../../core/presentation/utils/riverpod_framework.dart';
import '../../../../../core/presentation/widgets/cached_network_image_rounded.dart';
import '../../../../../core/presentation/widgets/custom_appbar.dart';
import '../../../../../core/presentation/widgets/platform_widgets/platform_appbar.dart';
import '../../../../../core/presentation/widgets/responsive_widgets/responsive_center.dart';
import '../../components/articles_components.dart';
import '../../providers/articles_provider.dart';
import '../../providers/open_website_provider.dart';

class ArticleDetailsScreenCompact extends ConsumerWidget {
  const ArticleDetailsScreenCompact({required this.articleIndex, super.key});

  final int articleIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final article = ref.watch(articlesProvider).requireValue.items[articleIndex];

    ref.easyListen(openWebsiteStateProvider);

    return Scaffold(
      appBar: PlatformAppBar(
        appbar: CustomAppBar(
          hasBackButton: true,
          title: Text(
            tr(context).linkDevelopment.toUpperCase(),
            style: TextStyles.appBarTitle(context),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: Sizes.screenPaddingV24,
            bottom: Sizes.screenPaddingV24 + Sizes.homeIndicatorHeight,
            right: Sizes.screenPaddingH24,
            left: Sizes.screenPaddingH24,
          ),
          child: ResponsiveCenter(
            child: Column(
              children: [
                Container(
                  decoration: ArticlesList.cardDecoration(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          CachedNetworkImageRounded(
                            imageUrl: article.image,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(ArticlesList.cardRadius),
                            ),
                            height: 200,
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: Text(
                              DateHelper.convertDateTimeToShortDate(context, article.publishDate),
                              style: TextStyles.f16(context).copyWith(
                                color: customColors(context).whiteColor,
                                fontWeight: FontStyles.fontWeightNormal,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      ArticleItem.mediumVGap,
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
                            ),
                            ArticleItem.smallVGap,
                            Text(
                              tr(context).byAuthor(article.author),
                              style: TextStyles.f16(context).copyWith(
                                color: customColors(context).greyColor,
                                fontWeight: FontStyles.fontWeightNormal,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            ArticleItem.mediumVGap,
                            Text(
                              article.description,
                              style: TextStyles.f16(context).copyWith(
                                color: customColors(context).greyColor,
                                fontWeight: FontStyles.fontWeightNormal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ArticleItem.mediumVGap,
                    ],
                  ),
                ),
                const SizedBox(height: Sizes.marginV20),
                OpenWebsiteButton(url: article.url),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
