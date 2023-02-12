import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageLoader extends StatelessWidget {
  const ImageLoader({
    Key? key,
    required this.imageUrl,
    this.errorImagePath,
    this.width,
    this.height,
    required this.borderRadius,
    this.imageProvider,
  }) : super(key: key);

  final String imageUrl;

  final double? width;

  final double? height;

  final double borderRadius;

  final String? errorImagePath;

  final ImageProvider? imageProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: imageProvider == null
          ? imageUrl != ""
              ? CachedNetworkImage(
                  imageUrl: imageUrl,
                  maxHeightDiskCache: 300,
                  maxWidthDiskCache: 300,
                  imageBuilder: (ctx, imgProvider) => Image(
                    image: imgProvider,
                    fit: BoxFit.cover,
                  ),
                  placeholder: (ctx, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (ctx, url, err) => Image(
                    image: AssetImage(
                      errorImagePath ?? "assets/images/user (4).png",
                    ),
                    fit: BoxFit.contain,
                  ),
                )
              : Image(
                  image: AssetImage(
                    errorImagePath ?? "assets/images/user (4).png",
                  ),
                  fit: BoxFit.contain,
                )
          : Image(
              image: imageProvider!,
              fit: BoxFit.cover,
            ),
    );
  }
}
