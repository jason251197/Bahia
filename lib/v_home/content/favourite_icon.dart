import 'package:flutter/material.dart';
import 'package:appclientes/v_home/controller/index.dart';

class FavouriteIcon extends StatefulWidget {
  const FavouriteIcon({
    Key key,
    @required this.local,
    @required this.product,
  }) : super(key: key);

  final LocalModel local;
  final ProductModel product;

  @override
  _FavouriteIconState createState() => _FavouriteIconState();
}

class _FavouriteIconState extends State<FavouriteIcon>
    with SingleTickerProviderStateMixin {
  int idFavorito = 0;
  AnimationController _animacionController;

  @override
  void initState() {
    super.initState();
    if (this.widget.product != null) {
      idFavorito = widget.product?.idFavorito;
    }
    if (this.widget.local != null) {
      idFavorito = widget.local?.idFavorito;
    }
    _animacionController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
      value: 1,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animacionController.dispose();
  }

  void addOrUpdate() {
    FavouriteModel _f;
    int idLocalProducto = this.widget.product != null
        ? (this.widget.product.productCode.indexOf("PRO") != -1
            ? int.parse(this.widget.product.productCode.replaceAll("PRO", ""))
            : int.parse(this.widget.product.productCode.replaceAll("PAQ", "")))
        : int.parse(this.widget.local.localCode.replaceAll("LOC", ""));
    if (idFavorito == null) {
      _animacionController.repeat();
      _f = FavouriteModel(
        idLocalProduct: idLocalProducto,
        type: this.widget.product != null ? 2 : 1,
      );
      HomeEvents.addFavourite(_f).then((value) {
        setState(() {
          if (value.id != null) {
            idFavorito = value.id;
          }
        });
        if (this.widget.product != null) {
          this.widget.product.idFavorito = value.id;
        }
        if (this.widget.local != null) {
          this.widget.local.idFavorito = value.id;
        }
        _animacionController.forward();
      }).catchError((error) => _animacionController.forward());
    } else {
      _f = FavouriteModel(id: idFavorito);
      HomeEvents.updateFavourite(_f).then((value) {
        setState(() {
          idFavorito = null;
        });
        if (this.widget.product != null) {
          this.widget.product.idFavorito = null;
        }
        if (this.widget.local != null) {
          this.widget.local.idFavorito = null;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!_animacionController.isAnimating) {
          addOrUpdate();
        }
      },
      child: ScaleTransition(
        scale: CurvedAnimation(
          parent: _animacionController,
          curve: Curves.bounceInOut,
        ),
        child: Icon(
          idFavorito != null ? Icons.favorite : Icons.favorite_border,
          color: idFavorito != null ? Colors.red : Colors.white,
          size: 31.0,
        ),
      ),
    );
  }
}
