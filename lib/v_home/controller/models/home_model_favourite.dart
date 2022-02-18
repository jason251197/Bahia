part of '../index.dart';

class FavouriteModel {
  FavouriteModel({
    this.id,
    this.idLocalProduct,
    this.idClient,
    this.type,
  });

  int id;
  int idLocalProduct;
  String idClient;
  int type;

  factory FavouriteModel.fromJson(Map<String, dynamic> json) => FavouriteModel(
        id: json["data"]["id"] ?? null,
        idLocalProduct: json["data"]["idlocalproducto"] ?? 0,
        idClient: json["data"]["idcliente"] ?? '',
        type: json["data"]["tipo"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idlocalproducto": idLocalProduct,
        "idcliente": idClient,
        "tipo": type,
      };

  Map<String, dynamic> addFavourite(favourite) => {
        "entity": {
          "id": 0,
          "idlocalproducto": favourite.idLocalProduct,
          "idcliente": favourite.idClient,
          "tipo": favourite.type,
        }
      };

  Map<String, dynamic> updateFavourite(favourite) => {
        "entity": {
          "id": favourite.id,
          "idlocalproducto": 0,
          "idcliente": favourite.idClient,
          "tipo": 0,
        }
      };
}
