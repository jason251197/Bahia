part of '../index.dart';

class CardRepository {
  static Future<CardList> getUserCards(
      [String codClient, bool showSuccess = false]) async {
    if (codClient is String && codClient.isNotEmpty) {
      CardList cards;
      await ApiService.fetch(
        Apis.getCardByClient(CardModel.getCardList(codClient)),
        verifyBasicToken: showSuccess,
        showSuccessDialog: showSuccess,
        showLoading: showSuccess,
        onSuccess: (res) =>
            res.data is Map && res.data["entity"]["datalist"] is List
                ? cards = CardList.fromJson(res.data["entity"])
                : null,
      );

      return cards;
    }
    return null;
  }
  
  static Future<CardList> getUserCards2(
      [String codClient, bool showSuccess = false]) async {
    if (codClient is String && codClient.isNotEmpty) {
      CardList cards;
      await ApiService.fetch(
        Apis.getCardByClient(CardModel.getCardList(codClient)),
        verifyBasicToken: showSuccess,
        showSuccessDialog: showSuccess,
        showLoading: true,
        onSuccess: (res) =>
        res.data is Map && res.data["entity"]["datalist"] is List
            ? cards = CardList.fromJson(res.data["entity"])
            : null,
      );

      return cards;
    }
    return null;
  }

  static Future<bool> deleteCard([CardModel card]) async {
    var codClient = SessionService.getCodClient;
    return await ApiService.fetch(
      Apis.deleteCard(card.deleteCard(codClient)),
      onErrorMessage: "No hay contacto con servidor",
      verifyBasicToken: true,
    );
  }
}
