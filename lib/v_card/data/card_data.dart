import 'package:appclientes/shared/common.dart';
import 'package:appclientes/shared/constants/index.dart';
import 'package:appclientes/shared/helpers/form_controller.dart';
import 'package:appclientes/v_card/helper/card_formatter.dart';
import 'package:flutter/material.dart';

final List<Map<String, dynamic>> cardInputsData = [
  {
    'icon': Icon(Icons.credit_card, color: AppColors.gray),
    'hintText': 'Número de tarjeta',
    'textInputType': TextInputType.number,
    'validator': cardValidator,
    'formatter': [
      MaskedTextInputFormatter(mask: 'xxxx xxxx xxxx xxxx', separator: ' '),
    ],
    'controller': FormController.numberCardEvents,
    'textCapitalization': TextCapitalization.none,
  },
  {
    'icon': Texts.black('cvv', color: AppColors.gray, fontSize: 17),
    'hintText': 'CVV',
    'textInputType': TextInputType.number,
    'validator': ccvValidator,
    'formatter': [
      MaskedTextInputFormatter(mask: 'xxx', separator: ''),
    ],
    'controller': FormController.ccvController,
    'textCapitalization': TextCapitalization.none,
  },
  {
    'icon': Icon(Icons.person, color: AppColors.gray),
    'hintText': 'Nombre y apellido',
    'validator': fullNameValidator,
    'controller': FormController.nameCardEvents,
    'textCapitalization': TextCapitalization.words,
  },
  {
    'icon': AppIcon.path(AppIcon.calendar),
    'hintText': 'Fecha de caducidad',
    'textInputType': TextInputType.number,
    'validator': dateValidator,
    'formatter': [
      MaskedTextInputFormatter(mask: 'xx/xxxx', separator: '/'),
    ],
    'controller': FormController.dateCardEvents,
    'textCapitalization': TextCapitalization.none,
  },
];
