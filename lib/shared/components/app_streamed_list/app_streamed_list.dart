import 'package:appclientes/packages/pager/pager.dart';
import 'package:flutter/material.dart';

class StreamedList extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Future<bool> Function() onLoadMore;
  final Function builder;
  final Function getItems;
  final Stream streamer;
  final Stream<bool> reload;
  final String tag;
  final Widget Function(String) onEmpty;
  const StreamedList({
    Key key,
    this.onRefresh,
    this.onLoadMore,
    @required this.builder,
    @required this.getItems,
    this.streamer,
    this.reload,
    this.tag,
    this.onEmpty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (onRefresh is Function && onLoadMore is Function && streamer is Stream)
      return RefreshIndicator(
        onRefresh: () async => await onRefresh(),
        child: StreamBuilder(
            stream: streamer,
            builder: (context, snapshot) {
              return loadPager();
            }),
      );

    return Container();
  }

  Widget loadPager() {
    final List _list = getItems() ?? [];
    if (reload is Stream)
      return StreamBuilder(
          stream: reload,
          builder: (c, v) {
            return Pager(
              key: Key('${v?.data}$key'),
              tag: tag ?? '',
              onLoadMore: onLoadMore,
              onEmpty: onEmpty,
              child: child,
              isEmpty: _list.isEmpty,
            );
          });
    return Pager(onLoadMore: onLoadMore, child: child);
  }

  Widget get child {
    final List _list = getItems() ?? [];
    return ListView.builder(
        itemCount: _list.length,
        padding: EdgeInsets.zero,
        itemBuilder: (c, v) => builder(_list[v]));
  }
}
