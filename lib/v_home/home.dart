import 'package:appclientes/shared/constants/colors.dart';
import 'package:flutter/material.dart';

import 'content/categories.dart';
import 'content/elements.dart';
import 'content/search_types.dart';
import 'controller/index.dart';

class HomeView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          BuildCategories(),
          SearchTypes(),
          Expanded(
            child: StreamBuilder(
                stream: FilterState().preLoadingEvents,
                builder: (_, __) {
                  final preLoading = FilterState().isPreLoading;

                  if (preLoading) return LoadingWidget();
                  return _bodyHome();
                }),
          ),
        ],
      ),
    );
  }

  Widget _bodyHome() {
    return StreamBuilder(
        stream: FilterState().getEvents,
        builder: (context, snapshot) {
          final filter = FilterState().getValue;

          if (filter.isProductFilter) return BuildProducts();
          if (filter.isLocalFilter) return BuildLocals();
          return Container();
        });
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 33,
                height: 33,
                child: CircularProgressIndicator(
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(AppColors.yellow),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
