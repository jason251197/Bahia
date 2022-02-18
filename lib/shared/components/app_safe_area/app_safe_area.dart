import 'package:flutter/material.dart';

import '../../common.dart';

class TopSafeArea extends StatelessWidget {
  final Color color;
  final Widget child;
  const TopSafeArea({
    Key key,
    this.color,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).padding.top,
          color: color ?? AppColors.yellow,
        ),
        child ?? Container(),
      ],
    );
  }
}

class BottomSafeArea extends StatelessWidget {
  final Color color;
  final Widget child;
  const BottomSafeArea({
    Key key,
    this.color,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        child ?? Container(),
        Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).padding.bottom > 0
              ? MediaQuery.of(context).padding.bottom - 10
              : MediaQuery.of(context).padding.bottom,
          color: color ?? AppColors.yellow,
        ),
      ],
    );
  }
}

class DimensionsState {
  static DimensionsState _instance;

  DimensionsState._();

  factory DimensionsState() => _getInstance();

  Dimensions value;

  num get topArea => value?.topArea ?? 0;
  num get bottomArea => value?.bottomArea ?? 0;
  num get width => value?.width ?? 0;
  num get height => value?.height ?? 0;

  update(Dimensions dimensions) => value = dimensions;

  static DimensionsState _getInstance() {
    if (_instance == null) {
      _instance = DimensionsState._();
    }
    return _instance;
  }
}

class Dimensions {
  num topArea;
  num bottomArea;
  num height;
  num width;

  Dimensions({
    this.bottomArea,
    this.height,
    this.topArea,
    this.width,
  });
}
