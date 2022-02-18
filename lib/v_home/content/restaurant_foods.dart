import 'package:appclientes/shared/common.dart';
import 'package:appclientes/v_home/controller/index.dart';

import 'package:flutter/material.dart';

class BuildFoods extends StatelessWidget {
  final LocalModel local;
  const BuildFoods(this.local, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (local is! LocalModel) return Container();
    return FutureBuilder(
        future: HomeEvents.loadLocalProducts(local),
        // initialData: null,
        builder: (c, v) => handler(v));
  }

  Widget handler(AsyncSnapshot v) {
    if (v.connectionState == ConnectionState.waiting)
      return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [LoadingWidget()]);
    if (v.hasData && v.data.isNotEmpty)
      return ProductShortList(products: v.data);
    else if (v.hasData && v.data.isEmpty) return Container();
    return Container();
  }
}

class ProductShortList extends StatelessWidget {
  const ProductShortList({
    Key key,
    @required this.products,
  }) : super(key: key);

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    if (products is! List<ProductModel>) return Container();
    return Container(
      height: 180,
      child: ListView.builder(
          itemCount: products.length,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          itemBuilder: (c, v) {
            return ProductShortView(products[v]);
          }),
    );
  }
}

class ProductShortView extends StatelessWidget {
  final ProductModel product;
  const ProductShortView(
    this.product, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (product is! ProductModel) return Container();
    return GestureDetector(
      onTap: () => HomeEvents.goToFood(product, true),
      child: Padding(
        padding: EdgeInset.horizontal(10.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  AppImage(
                    tag: product?.id?.toString(),
                    url: product?.imagePath,
                    height: 110,
                    width: 140,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      color: product.background ?? AppColors.orange,
                      child: Texts.whiteBold(
                        product.discount,
                        fontSize: 17,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: 140,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Texts.black(product.productName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        fontSize: 15),
                    Texts.blackBold(product.price, fontSize: 17),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
