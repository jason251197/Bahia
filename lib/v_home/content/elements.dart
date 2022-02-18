import 'package:appclientes/shared/common.dart';
import 'package:appclientes/shared/components/app_streamed_list/app_streamed_list.dart';
import 'package:appclientes/v_home/controller/index.dart';
import 'package:flutter/material.dart';

import 'item.dart';

class BuildLocals extends StatelessWidget {
  const BuildLocals({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamedList(
      key: Key('locals'),
      tag: 'locales',
      onEmpty: notProductsOrLocal,
      streamer: LocalsState().getEvents,
      reload: ReloadState().getEvents,
      onRefresh: () async => await HomeEvents.reload(),
      onLoadMore: () async => await HomeEvents.nextPage,
      getItems: () => LocalsState().getValue ?? [],
      builder: (_) => BuildItem(local: _),
    );
  }
}

class BuildProducts extends StatelessWidget {
  const BuildProducts({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamedList(
      key: Key('products'),
      tag: 'productos',
      streamer: ProductState().getEvents,
      reload: ReloadState().getEvents,
      onEmpty: notProductsOrLocal,
      onRefresh: () async => await HomeEvents.reload(),
      onLoadMore: () async => await HomeEvents.nextPage,
      getItems: () => ProductState().getValue ?? [],
      builder: (_) => BuildItem(product: _),
    );
  }
}

Widget notProductsOrLocal(String msg) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
    child: Column(
      children: [
        Texts.black(
          "¡Ups! por el momento no tenemos " +
              msg +
              " disponibles en esta categoría. Pero estate atento que en cualquier momento pueden entrar al limbo.",
          textAlign: TextAlign.justify,
        ),
        Center(child: AppIcon.path(AppImages.ICONO_OLIVER, size: 70.0)),
      ],
    ),
  );
}
