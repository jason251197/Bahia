import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final num size;
  const LoadingWidget({
    Key key,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size ?? 20.0,
      width: size ?? 20.0,
      child: CircularProgressIndicator(),
    );
  }
}
