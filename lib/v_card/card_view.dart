import 'package:appclientes/shared/common.dart';
import 'package:appclientes/shared/keys/global_keys.dart';
import 'package:appclientes/v_card/data/card_data.dart';
import 'package:appclientes/shared/components/app_card/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'content/credit_card.dart';
import 'controller/index.dart';

class CardView extends StatelessWidget {
  final _cardController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AppViews.addCard(
      onBack: CardEvents.goBack,
      child: EdgeInset.appPadding(
        horizontal: 40.0,
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: AppKeys.cardFormKey,
                child: ListView(
                  children: [
                    for (Map input in cardInputsData)
                      _buildInputWSpacer(
                        icon: input["icon"],
                        hintText: input["hintText"],
                        controller: input["hintText"].contains('Numero')
                            ? _cardController
                            : input["controller"],
                        formatters: input["formatter"],
                        textInputType: input["textInputType"],
                        valdator: input["validator"],
                        textCapitalization: input["textCapitalization"],
                      ),
                    SaveTag(
                      "guardar tarjeta",
                      onPress: () => CardEvents.registerCard(_cardController),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildInputWSpacer({
  Widget icon,
  String hintText,
  TextEditingController controller,
  List<TextInputFormatter> formatters,
  TextInputType textInputType,
  String Function(String) valdator,
  TextCapitalization textCapitalization,
}) =>
    Column(
      children: [
        Padding(
          padding: EdgeInset.vertical(5.0),
          child: FormInput(
            key: Key(hintText),
            icon: icon,
            validator: valdator,
            inputFormatters: formatters,
            textInputType: textInputType,
            hintText: hintText,
            controller: controller,
            textCapitalization: textCapitalization,
          ),
        ),
        if (hintText.contains('Numero')) CreditCard(controller: controller),
      ],
    );
