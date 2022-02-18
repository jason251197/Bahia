import 'package:appclientes/shared/common.dart';
import 'package:appclientes/shared/components/app_gray_top_header/gray_top_header.dart';
import 'package:appclientes/v_home/controller/index.dart';

import 'package:flutter/material.dart';

class BuildCategories extends StatefulWidget {
  const BuildCategories({
    Key key,
  }) : super(key: key);

  @override
  _BuildCategoriesState createState() => _BuildCategoriesState();
}

class _BuildCategoriesState extends State<BuildCategories> {
  String categoryCode;
  String lastCategoryCall;

  @override
  Widget build(BuildContext context) {
    return GrayTopHeader(
      child: Container(
        child: StreamBuilder<List<CategoryModel>>(
            stream: CategoriesState().getEvents,
            builder: (context, snapshot) {
              if (CategoriesState().getValue.isEmpty) return const SizedBox();
              return ListView(scrollDirection: Axis.horizontal, children: [
                ...CategoriesState()
                    .getValue
                    .asMap()
                    .entries
                    .map((e) => _buildButton(e.key, e.value, handleChange)),
              ]);
            }),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    categoryCode = FilterState().getValue?.categoryCode;
  }

  void handleChange(int index, CategoryModel value) {
    final filterState = FilterState();

    filterState.setPreLoading;
    categoryCode = value?.catCode ?? '';

    filterState.updateCategory(value?.catCode);

    Future.delayed(Duration(milliseconds: 1400), () {
      if (categoryCode == value.catCode && lastCategoryCall != value.catName) {
        HomeEvents.onSwitchCategories(value.catCode);
        lastCategoryCall = value?.catName ?? '';
      } else if (categoryCode == value.catCode &&
          lastCategoryCall == value.catName) {
        filterState.cancelPreLoading;
      }
    });
  }

  Widget _buildButton(
    int key,
    CategoryModel value,
    Function onChange,
  ) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => onChange(key, value),
            child: StreamBuilder(
                stream: FilterState().getEvents,
                builder: (context, snapshot) {
                  final currentCode = FilterState().getValue.categoryCode;
                  return Container(
                    decoration: BoxDecoration(
                      color: value.catCode == currentCode
                          ? AppColors.yellow
                          : AppColors.graySoft2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    margin: EdgeInset.horizontal(10),
                    child: Texts.black(value?.catName ?? ''),
                  );
                }),
          ),
        ],
      );
}
