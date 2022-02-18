import 'package:appclientes/shared/common.dart';
import 'package:appclientes/v_home/content/favourite_icon.dart';
import 'package:appclientes/v_home/controller/index.dart';
import 'package:appclientes/shared/constants/images.dart';
import 'package:flutter/material.dart';

import 'item_details.dart';
import 'item_image.dart';

final num _paddingHBody = 10.0;

class BuildItem extends StatelessWidget {
  const BuildItem({
    Key key,
    this.height,
    this.type = IMG_DETAIL.COMMON,
    this.product,
    this.local,
  }) : super(key: key);

  final double height;
  final IMG_DETAIL type;
  final ProductModel product;
  final LocalModel local;

  @override
  Widget build(BuildContext context) {
    if (product is! ProductModel && local is! LocalModel) return Container();

    void onTap() {
      if (type == IMG_DETAIL.COMMON) {
        if (product is ProductModel) HomeEvents.goToFood(product);
        if (local is LocalModel) HomeEvents.goToRestaurant(local);
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height is double ? null : 200,
        padding: height is double
            ? EdgeInsets.zero
            : EdgeInsets.symmetric(horizontal: _paddingHBody, vertical: 8),
        child: _buildItem(),
      ),
    );
  }

  Widget _buildItem() {
    String url = urlImagen();
    if (height is double)
      return Column(
        children: [
          Stack(
            children: [
              BuildImage(
                url,
                //product?.imagePath ?? local?.imagePath ?? '',
                height: height,
                tag: product?.id ?? local?.id,
              ),
              Positioned(
                right: 10,
                top: 10,
                child: FavouriteIcon(local: local, product: product),
              ),
            ],
          ),
          BuildItemDetails(
            product: product,
            local: local,
            paddingBottom: height is double ? 0 : 10,
            type: type,
          ),
        ],
      );
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          BuildImage(
            url,
            //product?.imagePath ?? local?.imagePath ?? '',
            tag: product?.id ?? local?.id,
          ),
          Positioned(
            right: 10,
            top: 10,
            child: FavouriteIcon(local: local, product: product),
          ),
          BuildItemDetails(
            product: product,
            local: local,
            paddingBottom: height is double ? 0 : 10,
            type: type,
          ),
        ],
      ),
    );
  }

  String urlImagen() {
    String url = '';
    if (product != null) {
      url = product?.imagePath;
      if (url.length == 0) {
        url = AppImages.PRODUCTO_DEFAULT;
      } else {
        url = product.imagePath.replaceAll(' ', '%20');
        // url = AppImages.PRODUCTO_DEFAULT;
      }
    } else if (local != null) {
      url = local?.imagePath;
      if (url.length == 0) {
        url = AppImages.LOCAL_DEFAULT;
      } else {
        url = local.imagePath.replaceAll(' ', '%20');
        // url = AppImages.LOCAL_DEFAULT;
      }
    }
    return url;
  }
}
