import 'package:appclientes/shared/common.dart';
import 'package:flutter/material.dart';

class DialogCard {
  String text;
  Widget body;
  Widget icon;
  DialogButton button;
  DialogButton secondaryButton;
  TxtButton textButton;

  DialogCard(
    this.text, {
    this.body,
    this.button,
    this.textButton,
    this.icon,
    this.secondaryButton,
  });
}

class DialogButton extends StatelessWidget {
  final String message;
  final Function onPress;
  final bool boolean;
  final double width;
  final bool doPop;

  DialogButton(this.message,
      {this.onPress, this.width, this.boolean, this.doPop = true});
  @override
  Widget build(BuildContext context) {
    return Buttons.yellow(message ?? "", width: width, onClick: () {
      if (boolean is! bool && doPop)
        Navigator.pop(context);
      else if (doPop) Navigator.pop(context, boolean);
      if (onPress is Function) onPress();
    });
  }
}

class TxtButton extends StatelessWidget {
  final String text;
  final Function onPress;
  final bool boolean;
  TxtButton(this.text, {this.onPress, this.boolean});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (boolean is! bool)
          Navigator.pop(context);
        else
          Navigator.pop(context, boolean);
        if (onPress is Function) onPress();
      },
      child: Container(
        child: Texts.yellowBold(text?.toUpperCase() ?? '', fontSize: 15),
      ),
    );
  }
}

class DialogBase extends StatelessWidget {
  final String message;
  final DialogCard card;
  const DialogBase({
    Key key,
    this.message,
    this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (card is DialogCard) DialogCardBase(card),
          if (message is String) SimpleDialog(message),
        ],
      ),
    );
  }
}

class DialogCardBase extends StatelessWidget {
  final DialogCard card;
  DialogCardBase(this.card);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: EdgeInset.appDecoration(
        horizontal: 20.0,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            children: [
              if (card?.text is String)
                EdgeInset.appDecoration(
                    vertical: 10.0,
                    radius: BorderRadius.vertical(top: Radius.circular(10)),
                    alignment: Alignment.center,
                    color: AppColors.graySoft2,
                    child: Texts.black(card.text)),
              EdgeInset.appPadding(
                vertical: 10.0,
                horizontal: 0,
                child: Column(
                  children: [
                    if (card?.body is Widget)
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: card?.icon is Widget ? 40 : 0),
                        child: Row(
                          children: [
                            // if (card?.icon is Widget) Spacer(),
                            if (card?.icon is Widget)
                              Padding(
                                padding: EdgeInset.horizontal(8.0),
                                child: card.icon,
                              ),
                            Expanded(child: card.body),
                            // if (card?.icon is Widget) Spacer(),
                          ],
                        ),
                      ),
                    if (card?.textButton is TxtButton)
                      Padding(
                        padding: EdgeInset.vertical(10.0),
                        child: card.textButton,
                      ),
                    if (card?.secondaryButton is DialogButton)
                      card.secondaryButton,
                    if (card?.secondaryButton is DialogButton)
                      SizedBox(height: 10),
                    if (card?.button is DialogButton) card.button,
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SimpleDialog extends StatelessWidget {
  const SimpleDialog(
    this.message, {
    Key key,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      alignment: Alignment.center,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Texts.black(message ?? "", textAlign: TextAlign.center),
          SizedBox(height: 20),
          GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Texts.blackBold("Aceptar".toUpperCase(),
                  color: AppColors.gray)),
        ],
      ),
    );
  }
}
