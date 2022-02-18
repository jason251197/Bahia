part of '../index.dart';

class CardModel {
  String cardCode;
  String pan;
  String ccv;
  String name;
  String date;
  String codeclient;
  String brand;

  CardModel({
    this.cardCode,
    this.pan,
    this.ccv,
    this.name,
    this.date,
    this.codeclient,
    this.brand,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      cardCode: json["card_code"] ?? '',
      brand: json["brand"] ?? '',
      pan: json["pan"] ?? "",
      codeclient: json["codeclient"] ?? "",
    );
  }

  Map toJson() => {
        "card_code": cardCode ?? '',
        "pan": pan ?? '',
        "brand": brand ?? '',
        "codeclient": codeclient ?? '',
        //"ccv": ccv ?? '',
        //"name": name ?? '',
        //"date": date ?? '',
      };

  Map<String, dynamic> get json => {
        "card_code": cardCode ?? '',
        "pan": pan ?? '',
        "brand": brand ?? '',
        "codeclient": codeclient ?? '',
        //"ccv": ccv ?? '',
        //"name": name ?? '',
        //"date": date ?? '',
      };

  String get getLastDigits {
    return "**** **** **** $pan";
    //return "* * * *  ${number.length > 4 ? number.substring(number.length - 4) : ""}";
  }

  String get year {
    final index = date.indexOf("/");

    if (!index.isNegative) {
      return date.substring(index + 3, date.length);
    }
    return "";
  }

  get getNumber => pan.replaceAll("", "");

  String get month {
    final index = date.indexOf("/");
    if (!index.isNegative) {
      return date.substring(0, index);
    }
    return "";
  }

  static Map<String, dynamic> getCardList(codClient) => {
        "entity": {"codeclient": codClient}
      };

  Map<String, dynamic> deleteCard(codClient) => {
        "entity": {"card_code": cardCode, "codeclient": codClient}
      };
}

class CardList {
  List<CardModel> cards = <CardModel>[];
  CardList({this.cards});

  Map toJson() => {"datalist": cards};

  factory CardList.fromJson(Map<String, dynamic> json) => CardList(
        cards: List<CardModel>.from(
            json["datalist"].map((a) => CardModel.fromJson(a))),
      );

  List<CardModel> get getCards => cards ?? [];
}
