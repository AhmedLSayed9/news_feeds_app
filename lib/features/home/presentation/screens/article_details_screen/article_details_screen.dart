import 'package:flutter/material.dart';

import '../../../../../core/presentation/widgets/responsive_widgets/responsive_layouts.dart';
import 'article_details_screen_compact.dart';

class ArticleDetailsScreen extends StatelessWidget {
  const ArticleDetailsScreen({required this.articleIndex, super.key});

  final int articleIndex;

  @override
  Widget build(BuildContext context) {
    return WindowClassLayout(
      compact: (_) => OrientationLayout(
        portrait: (_) => ArticleDetailsScreenCompact(articleIndex: articleIndex),
      ),
    );
  }
}
