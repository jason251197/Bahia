import 'package:appclientes/packages/pager/pager.dart';
import 'package:flutter/material.dart';

// import '../../common.dart';

class RenderList extends StatelessWidget {
  final Future<bool> Function() onRefresh;
  final Future<bool> Function() onLoadMore;
  final Function builder;
  final List items;
  const RenderList({
    Key key,
    this.onRefresh,
    this.onLoadMore,
    @required this.builder,
    @required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (onRefresh is Function && onLoadMore is! Function)
      return RefreshIndicator(
        onRefresh: () async => await onRefresh(),
        child: child,
        // backgroundColor: AppColors.yellow,
      );

    if (onRefresh is Function && onLoadMore is Function)
      return RefreshIndicator(
        onRefresh: () async => await onRefresh(),
        child: Pager(onLoadMore: onLoadMore, child: child),
        // backgroundColor: AppColors.yellow,
      );
    return child;
  }

  Widget get child => ListView.builder(
      itemCount: items?.length ?? [],
      padding: EdgeInsets.zero,
      itemBuilder: (c, v) => builder(items[v]) ?? Container());
}
