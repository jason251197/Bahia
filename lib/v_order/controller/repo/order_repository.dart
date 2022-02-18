part of '../index.dart';

class OrderRepository {
  static Future<OrderList> getOrdersByClient(
      [String codClient, bool showSuccess = false, bool showSuccessDialog = false]) async {
    if (codClient is String && codClient.isNotEmpty) {
      OrderList orders;
      await ApiService.fetch(
        Apis.getOrdersByClient(OrderModel.getOrderList(codClient)),
        verifyBasicToken: showSuccess,
        showSuccessDialog: showSuccessDialog,
        showLoading: showSuccess,
        onSuccess: (res) =>
            res.data is Map && res.data["entity"]["datalist"] is List
                ? orders = OrderList.fromJson(res.data["entity"])
                : null,
      );

      return orders;
    }
    return null;
  }
  /*
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
  }*/
}
