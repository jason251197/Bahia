part of '../index.dart';

class CardEvents {
  static void addCard(CardModel address) async {
    await CardCache.setSelectedCard(address);
    if (await CardCache.addCardList(address))
      await Fake.loading.then((value) => NavigationService().pop());
  }

  static void goBack() {
    FormController.clean();
    NavigationService().pop();
  }

  ///[@deprecrated]
  static Future<void> registerCard(TextEditingController cardNumber) async {
    // /// [FIIL WITH REPOSITORY]
    // if (AppKeys.cardFormKey.currentState.validate()) {
    //   CardModel _cardModel = CardModel();
    //   //_cardModel.number = cardNumber.text;
    //   _cardModel.ccv = FormController.ccvController.text;
    //   _cardModel.name = FormController.nameCardEvents.text;
    //   _cardModel.date = FormController.dateCardEvents.text;

    //   if (await CardCache.addCardList(_cardModel)) {
    //     FormController.clean();
    //     await Fake.loading.then((value) => NavigationService().pop());
    //   }
    // }
  }

  static Future<void> goToAddCard() async {
    if (await AppConnectivity.check()) {
      return NavController.goToCardWebView();
    }
  }

  static CardList get loadCardlIst =>
      CardCache?.getCardList ?? CardList(cards: []);

  //static Future<void> deleteCard(CardModel cardModel) async =>
    //  await CardCache.deleteCard(cardModel);

  static Future<bool> deleteCard(CardModel cardModel) async {
    if (await DialogService.deleteCard) {
      if (await CardRepository.deleteCard(cardModel))
        return await CardCache.deleteCard(cardModel);
    }
    return false;
  }
}
