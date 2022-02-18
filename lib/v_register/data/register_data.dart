import 'package:appclientes/shared/components/app_form_input/app_form_input.dart';
import 'package:appclientes/shared/constants/general.dart';
import 'package:appclientes/shared/helpers/form_controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

final List<Map<String, dynamic>> inputsData = [
  {
    'icon': Icon(Icons.person),
    'hintText': 'Nombres',
    'validator': nameValidator,
    'textInputType': TextInputType.name,
    'controller': FormController.nameController,
    'inputFormatters': [
      FilteringTextInputFormatter.singleLineFormatter,
    ],
    'textCapitalization': TextCapitalization.words,
  },
  {
    'icon': Icon(Icons.person),
    'hintText': 'Apellidos',
    'validator': lastNameValidator,
    'textInputType': TextInputType.name,
    'controller': FormController.lastNController,
    'inputFormatters': [
      FilteringTextInputFormatter.singleLineFormatter,
    ],
    'textCapitalization': TextCapitalization.words,
  },
  {
    'icon': Icon(Icons.mail),
    'hintText': 'Correo electrónico',
    'validator': emailValidator,
    'textInputType': TextInputType.emailAddress,
    'controller': FormController.emailController,
    'inputFormatters': [
      FilteringTextInputFormatter.singleLineFormatter,
    ],
    'textCapitalization': TextCapitalization.none,
  },
  {
    // 'icon': AppIcon.path(AppIcon.phone),
    'icon': Icon(Icons.phone_iphone),
    'hintText': 'Teléfono',
    'validator': phoneValidator,
    'textInputType': TextInputType.phone,
    'controller': FormController.phoneController,
    'inputFormatters': [
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      LengthLimitingTextInputFormatter(10),
    ],
    'textCapitalization': TextCapitalization.none,
  },
  {
    'icon': Icon(Icons.lock),
    'hintText': CConsts.password,
    'validator': passwordValidator,
    'controller': FormController.password2Controller,
    'inputFormatters': [
      FilteringTextInputFormatter.singleLineFormatter,
      LengthLimitingTextInputFormatter(12),
    ],
    'textCapitalization': TextCapitalization.none,
    'obscureText': true,
  },
  {
    // 'icon': AppIcon.path(AppIcon.lock),
    'icon': Icon(Icons.lock_outline),
    'hintText': 'Confirmar contraseña',
    'validator': confirmPasswordValidator,
    'controller': FormController.password3Controller,
    'inputFormatters': [
      FilteringTextInputFormatter.singleLineFormatter,
    ],
    'textCapitalization': TextCapitalization.none,
    'obscureText': true,
  },
];
