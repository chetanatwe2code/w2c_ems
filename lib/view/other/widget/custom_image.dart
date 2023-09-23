import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../utils/assets.dart';

class CustomImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final double radius;
  final Color? errorBackground;
  final BoxFit? fit;
  final String? assetPlaceholder;

  const CustomImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.radius = 10,
    this.errorBackground,
    this.fit,
    this.assetPlaceholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: '$imageUrl',
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        placeholder: (context, url) => Stack(
          children: [
            Image.asset(assetPlaceholder??appPlaceholder,
              width: width,
              height: height,
              fit: fit ?? BoxFit.cover,),
            const Center(
              child: SizedBox(
                  width: 15.0,
                  height: 15.0,
                  child: CircularProgressIndicator(strokeWidth: 1.0,color: AppColors.primary,)
              ),),
          ],
        ),
        errorWidget: (_, __, ___) => Image.asset(assetPlaceholder??appPlaceholder,
          width: width,
          height: height,
          fit: fit ?? BoxFit.cover,),
      ),
    );
  }
}
