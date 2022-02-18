import 'package:appclientes/shared/components/app_form_input/app_form_input.dart';
import 'package:appclientes/shared/helpers/form_controller.dart';
import 'package:appclientes/v_profile/controller/profile_controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

final profileInputsData = [
  {
    'type': 'Nombres:',
    'key': PROFILE_INPUT.NAME,
    'hintText': '',
    'validator': nameValidator,
    'textInputType': TextInputType.name,
    'controller': FormController.nameController,
    'inputFormatters': [
      FilteringTextInputFormatter.singleLineFormatter,
    ],
    'textCapitalization': TextCapitalization.words,
  },
  {
    'type': "Apellidos:",
    'key': PROFILE_INPUT.LASTNAME,
    'hintText': '',
    'validator': lastNameValidator,
    'textInputType': TextInputType.name,
    'controller': FormController.lastNController,
    'inputFormatters': [
      FilteringTextInputFormatter.singleLineFormatter,
    ],
    'textCapitalization': TextCapitalization.words,
  },
  {
    'type': "Correo\nelectrónico:",
    'key': PROFILE_INPUT.EMAIL,
    'hintText': '',
    'validator': emailValidator,
    'textInputType': TextInputType.emailAddress,
    'controller': FormController.emailController,
    'inputFormatters': [
      FilteringTextInputFormatter.singleLineFormatter,
    ],
    'textCapitalization': TextCapitalization.none,
  },
  {
    'type': "Teléfono:",
    'key': PROFILE_INPUT.PHONE,
    'hintText': '',
    'validator': phoneValidator,
    'textInputType': TextInputType.phone,
    'controller': FormController.phoneController,
    'inputFormatters': [
      FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+$')),
      LengthLimitingTextInputFormatter(10),
    ],
    'textCapitalization': TextCapitalization.none,
  },
];

enum PROFILE_INPUT {
  NAME,
  LASTNAME,
  EMAIL,
  PHONE,
}

class InfoData {
  static const List<Map<String, dynamic>> infoAppData_1 = [
    {
      'title': 'Términos y condiciones',
      'onPress': ProfileController.openTerms,
      'icon': Icons.insert_drive_file,
    },
    {
      'title': 'Cómo funciona Oliver',
      'onPress': ProfileController.showOnBoard,
      'icon': Icons.help,
    },
  ];

  static const List<Map<String, dynamic>> infoAppData_2 = [
    {
      'title': 'Comunícate con nosotros',
      'onPress': ProfileController.contactUs,
      'icon': Icons.mode_comment,
    },
  ];
  static const List<Map<String, dynamic>> infoAppData_3 = [
    {
      'title': 'Eliminar mi cuenta',
      'icon': Icons.cancel,
      'onPress': ProfileController.cancelAccount,
    },
    /*{
      'title': 'Anular mi último pedido',
      'icon': Icons.remove_circle,
      'onPress': ProfileController.cancelOrder,
    },*/
    {
      'title': 'Cerrar sesión',
      'icon': Icons.power_settings_new,
      'onPress': ProfileController.logout,
    },
  ];
}
