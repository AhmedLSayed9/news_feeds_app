import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import '../../../gen/my_assets.dart';
import '../../infrastructure/services/cache_service.dart';
import '../utils/riverpod_framework.dart';

class CachedNetworkImageRounded extends ConsumerWidget {
  const CachedNetworkImageRounded({
    required this.imageUrl,
    required this.borderRadius,
    this.height = double.infinity,
    this.width = double.infinity,
    this.boxShadow,
    this.colorFilter,
    this.spareImageUrl = 'https://archive.org/download/placeholder-image/placeholder-image.jpg',
    this.maxHeightDiskCache = 600,
    this.maxWidthDiskCache = 600,
    super.key,
  });
  final String? imageUrl;
  final String spareImageUrl;
  final BorderRadiusGeometry? borderRadius;
  final double? height;
  final double? width;
  final List<BoxShadow>? boxShadow;
  final ColorFilter? colorFilter;
  final int? maxHeightDiskCache;
  final int? maxWidthDiskCache;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cacheService = ref.watch(cacheServiceProvider);

    return CachedNetworkImage(
      key: UniqueKey(),
      cacheManager: cacheService.customCacheManager,
      imageUrl: imageUrl != null && imageUrl!.contains('http') ? imageUrl! : spareImageUrl,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            colorFilter: colorFilter,
          ),
          boxShadow: boxShadow,
        ),
      ),
      placeholder: (context, url) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          image: const DecorationImage(
            image: AssetImage(MyAssets.ASSETS_IMAGES_CORE_LOADING_GIF),
            fit: BoxFit.cover,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          image: const DecorationImage(
            image: AssetImage(MyAssets.ASSETS_IMAGES_CORE_PLACEHOLDER_PNG),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
