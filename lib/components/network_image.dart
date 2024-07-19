import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomCachedImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit? fit;
  final BlendMode? colorBlendMode;
  final double? width;
  final double? radius;
  final double? height;
  final bool? showUser;
  final bool? showLogo;
  final Color? progressColor;

  const CustomCachedImage({
    super.key,
    required this.imageUrl,
    this.fit,
    this.colorBlendMode,
    this.width,
    this.height,
    this.radius,
    this.showUser,
    this.showLogo,
    this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      clipBehavior: Clip.antiAlias,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit ?? BoxFit.cover,
        colorBlendMode: colorBlendMode ?? BlendMode.screen,
        width: width,
        height: height,
        progressIndicatorBuilder: (context, url, downloadProgress) => showUser == true
            ? Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(radius ?? 0),
                ),
                child: Center(child: CupertinoActivityIndicator(radius: 15, color: progressColor)))
            : showLogo == true
                ? Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: width ?? double.infinity,
                      height: height ?? double.infinity,
                      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5)),
                    ),
                  )
                : Center(child: CupertinoActivityIndicator(radius: 15, color: progressColor)),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey.shade100,
          height: double.infinity,
          width: double.infinity,
          child: showUser == true ? Icon(CupertinoIcons.person, color: Colors.grey.shade400, size: 23) : Icon(CupertinoIcons.photo, color: Colors.grey.shade400),
        ),
      ),
    );
  }
}
