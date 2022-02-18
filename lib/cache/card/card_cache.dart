part of '../cache.dart';

class CardCache {
  static const String _CARD_LIST = "card_list";
  static const String _CARD_SELECTED = "card_current";

  static const List<String> _KEY_LIST = [
    _CARD_LIST,
    _CARD_SELECTED,
  ];

  static CardModel get getCurrentCard {
    try {
      String _card = cache.getString(_CARD_SELECTED);
      Map data = AppConverter.toObject(_card);
      return CardModel.fromJson(data);
    } catch (err, stack) {
      Logger.err("getCurrentCard", err, stack);
    }
    return null;
  }

  static Future<bool> setSelectedCard(CardModel card) async {
    try {
      String _card = AppConverter.toJson(card);
      await cache.setString(_CARD_SELECTED, _card);
    } catch (err, stack) {
      Logger.err("setSelectedCard", err, stack);
    }
    return false;
  }

  static Future<bool> setCardList(CardList cardList) async {
    try {
      String _json = AppConverter.toJson(cardList);
      return await cache.setString(_CARD_LIST, _json);
    } catch (err) {
      Logger.err("setCardList", err);
    }
    return false;
  }

  static Future<bool> addCardList(CardModel card) async {
    try {
      CardList cardList = CardCache?.getCardList ?? CardList();
      cardList.cards = [card, ...cardList.getCards];
      return await setCardList(cardList);
    } catch (err, stack) {
      Logger.err("addCardList", err, stack);
    }
    return false;
  }

  static Future<bool> deleteCard(CardModel card) async {
    try {
      CardList cardList = CardCache?.getCardList ?? CardList();
      cardList.cards.removeWhere((e) => e.cardCode == card.cardCode);
      return await setCardList(cardList);
    } catch (err, stack) {
      Logger.err("deleteCard", err, stack);
    }
    return false;
  }

  static CardList get getCardList {
    try {
      String _list = cache.getString(_CARD_LIST);
      if (_list is String) {
        Map data = AppConverter.toObject(_list);
        return CardList.fromJson(data);
      }
    } catch (err) {
      Logger.err("getCardList", err);
    }
    return null;
  }

  ///Shared Preference Method to delete data from SharedPreferences
  static Future get deleteCache async {
    _KEY_LIST.forEach((key) => cache.remove(key));
  }
}
