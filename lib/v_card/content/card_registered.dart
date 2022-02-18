import 'package:appclientes/shared/common.dart';
import 'package:appclientes/v_card/controller/index.dart';
import 'package:appclientes/shared/helpers/converter.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:appclientes/shared/helpers/form_controller.dart';
import 'package:appclientes/v_cart/controller/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum CARD_REGISTER {
  PROFILE,
  CART,
}

class CardRegistered extends StatefulWidget {
  final CARD_REGISTER type;
  final Function(CardModel) selectedCard;
  const CardRegistered({
    Key key,
    this.type = CARD_REGISTER.PROFILE,
    this.selectedCard,
  }) : super(key: key);

  @override
  _CardRegisteredState createState() => _CardRegisteredState();
}

class _CardRegisteredState extends State<CardRegistered> {
  CardList cardList;
  int selectedCardIndex;
  @override
  void initState() {
    //selectedCardIndex = -1;
    selectedCardIndex = CartState().getCardIndex();
    cardList = CardEvents.loadCardlIst;
    if (widget.type == CARD_REGISTER.CART && cardList.cards.length >0) {
      if (selectedCardIndex ==0 )  enabledText = true;
      CartState().setCardIndex(selectedCardIndex);
      CartState().setCardModel(cardList.cards[selectedCardIndex]);
      widget.selectedCard(cardList.cards[selectedCardIndex]);
    }
    super.initState();
  }

  void onIndexChange(int index) {
    if (index == 0) {
      enabledText = true;
    }else {
      enabledText = false;
    }
    setState(() => selectedCardIndex = index);
    selectedCardIndex = index;
    if (widget.type == CARD_REGISTER.CART) {
      CartState().setCardIndex(selectedCardIndex);
      CartState().setCardModel(cardList.cards[selectedCardIndex]);
    }
    /*
    if (widget.selectedCard is Function)
      widget.selectedCard(cardList.cards[index]);
    setState(() => selectedCardIndex = index);
    */
  }

  void get rebuild {
    setState(() {
      selectedCardIndex = 0;
      cardList = CardEvents.loadCardlIst;
    });
    if (widget.selectedCard is Function) widget.selectedCard(cardList.cards[0]);
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      title: widget.type == CARD_REGISTER.PROFILE ? "tarjetas registradas" : "Métodos de Pago",
      buildOpen: widget.type == CARD_REGISTER.CART,
      child: Column(
        children: [
          ...cardList.cards.asMap().entries.map(
                (e) => _buildCard(
                  card: e.value,
                  index: e.key,
                  selected: selectedCardIndex,
                  onPress: onIndexChange,
                  onDelete: (CardModel v) =>
                      CardEvents.deleteCard(v).then((_) => rebuild),
                ),
              ),
          SaveTag(
            'agregar tarjeta',
            onPress: () => CardEvents.goToAddCard().then((_) => rebuild),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCard({
    CardModel card,
    int index,
    int selected,
    Function(int) onPress,
    Function(CardModel) onDelete,
  }) {
    if(widget.type == CARD_REGISTER.CART){
      if (index == 0){
        return _buildPagoEfectivo(card, index, selected, onPress, onDelete);
      }else {
        return _buildCardList(card, index, selected, onPress, onDelete);
      }
    }else{
      if (cardList.cards.length == 0){
        return Container();
      }else{
        if (index == 0) {
          return Container();
        }else{
          return _buildCardList(card, index, selected, onPress, onDelete);
        }
      }
    }
  }
  
  bool enabledText = false;
  FocusNode myFocusNode = new FocusNode();

  Widget _buildPagoEfectivo(
      CardModel card,
      int index,
      int selected,
      Function(int) onPress,
      Function(CardModel) onDelete,
      ) {
    return CardField(
      paddingH: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Texts.blackBold("Pago en\nEfectivo"),
              SizedBox(width: 25),
              Container(
                width: 170.0,height: 45.0,
                child: TextField(
                controller: FormController.billController,
                focusNode: myFocusNode,
                enabled: enabledText,
                textAlign: TextAlign.right,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  BlacklistingTextInputFormatter(r"\S"),
                  LengthLimitingTextInputFormatter(20),
                  ThousandsFormatter(formatter: oCcy,allowFraction: true),
                ],
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 7.0,right: 5.0, top: 15.0, bottom: 12.0),
                  prefixText: AppConverter.COP_SYMBOL,
                  isDense: true,
                  labelText: '¿Con cuánto vas a pagar?',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.black : Colors.grey,
                    //fontSize:  myFocusNode.hasFocus ? 16 : 14,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      style: BorderStyle.solid,
                      width: 1,
                    ),
                  ),
                ),
                style: TextStyle(fontSize: 14.0, color: Colors.black,fontFamily: FontFamily.REGULAR_ASSISTANT,),
                ),
              ),
              //Texts.blackBold("card.getLastDigits", fontSize: 16),
            ],
          ),
          Container(
            child: Radio(
              value: index,
              groupValue: selectedCardIndex,
              onChanged: onIndexChange,
            ),
          ),
        ],
      ),
    );
  }

  /*
  Widget _buildCard({
    CardModel card,
    int index,
    int selected,
    Function(int) onPress,
    Function(CardModel) onDelete,
  }) {
    */
  Widget _buildCardList(
    CardModel card,
    int index,
    int selected,
    Function(int) onPress,
    Function(CardModel) onDelete,
  ) {
    return CardField(
      paddingH: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              AppIcon.path(AppIcon.getCardType(card?.brand) ?? AppIcon.defaultcard,
                  width: 48.0),
              SizedBox(width: 40),
              Texts.blackBold(card.getLastDigits, fontSize: 16),
            ],
          ),
          widget.type == CARD_REGISTER.PROFILE
              ? XButton(
                  onDelete: onDelete,
                  model: card,
                )
              : Container(
                  child: Radio(
                    value: index,
                    groupValue: selectedCardIndex,
                    onChanged: onIndexChange,
                  ),
                ),
        ],
      ),
    );
  }
}
