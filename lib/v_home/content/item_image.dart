import 'package:appclientes/shared/common.dart';
import 'package:flutter/material.dart';

class BuildImage extends StatelessWidget {
  final double height;
  final String url;
  final Object tag;

  const BuildImage(
    this.url, {
    Key key,
    this.height,
    this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppImage(
          tag: tag?.toString(),
          url: url,
          height: 200,
          width: MediaQuery.of(context).size.width,
        ),
        Container(
          color: !(height is double)
              ? AppColors.black.withOpacity(0.3)
              : Colors.transparent,
        ),
      ],
    );
  }
}
