import 'dart:math';

import 'package:appclientes/shared/common.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    Key key,
    this.tag,
    @required this.url,
    this.height,
    this.width,
    this.loadingSize,
    this.fit,
  }) : super(key: key);

  final String tag;
  final String url;
  final num height;
  final num width;
  final num loadingSize;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    if (tag is String)
      return Hero(
        tag: tag ?? Random.secure().nextInt(1000).toString(),
        child: _build,
      );
    return _build;
  }

  Container get _build {
    final _boxFit = fit ?? BoxFit.fill;
    return Container(
      height: height?.toDouble() ?? 200,
      width: width?.toDouble() ?? 200,
      child: CachedNetworkImage(
        imageUrl: url ?? '',
        imageBuilder: (context, imageProvider) =>
            Image(image: imageProvider, fit: _boxFit),
        placeholder: (context, url) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [LoadingWidget(size: loadingSize)]),
        errorWidget: (context, url, error) =>
            Image(image: AssetImage(AppImages.PRODUCT_DEFAULT), fit: _boxFit),
      ),
    );
  }
}
