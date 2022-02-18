import 'package:appclientes/shared/helpers/converter.dart';

String simpleFieldValidator(String value) {
  if (value.isEmpty) return 'Campo no puede estar en blanco';

  if (value.length < 4) return 'Campo tiene que tener al menos 4 caracteres';

  if (value.length > 30) return 'Campo tiene que tener menos de 30 caracteres';

  return null;
}

String passwordLoginValidator(String value) {
  if (value.isEmpty) return 'Debes ingresar tu contraseña';

  //if (value.length != 8) return 'La contraseña no es válida';

  return null;
}

String passwordValidator(String value) {
  if (value.isEmpty) return 'Debes ingresar una contraseña';

  if (value.length < 8) return 'La contraseña debe tener mínimo 8 caracteres';

  return null;
}

String confirmPasswordValidator(String value) {
  if (value.isEmpty) return 'Debes repetir la contraseña';

  if (value.length < 8) return 'La contraseña debe tener mínimo 8 caracteres';

  return null;
}

String emailValidator(String value) {
  if (value.isEmpty) return 'Debes ingresar tu correo electrónico';
  if (RegExp(
          r"^((([a-zA-Z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-zA-Z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-zA-Z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-zA-Z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-zA-Z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-zA-Z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-zA-Z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-zA-Z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-zA-Z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-zA-Z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$")
      .hasMatch(value)) {
    return null;
  } else {
    return "El correo electrónico no es válido";
  }
}

String wordlValidator(String value) {
  if (RegExp(
          r"^[a-zA-ZÀ-ÿ\u00f1\u00d1]+(\s*[a-zA-ZÀ-ÿ\u00f1\u00d1]*)*[a-zA-ZÀ-ÿ\u00f1\u00d1]+$")
      .hasMatch(value)) {
    return null;
  } else {
    return "Campo no tiene un formato correcto";
  }
}

String fullNameValidator(String value) {
  if (value.isEmpty) return 'Debes ingresar tu nombre y apellido';
  if (value.length < 2) return null;

  if (RegExp(
          r"^[a-zA-ZÀ-ÿ\u00f1\u00d1]+(\s*[a-zA-ZÀ-ÿ\u00f1\u00d1]*)*[a-zA-ZÀ-ÿ\u00f1\u00d1]+$")
      .hasMatch(value)) {
    return null;
  } else {
    return "El nombre y apellido ingresado es incorrecto";
  }
}

String nameValidator(String value) {
  if (value.isEmpty) return 'Debes ingresar tus nombres';
  if (value.length < 2) return null;

  if (RegExp(
          r"^[a-zA-ZÀ-ÿ\u00f1\u00d1]+(\s*[a-zA-ZÀ-ÿ\u00f1\u00d1]*)*[a-zA-ZÀ-ÿ\u00f1\u00d1]+$")
      .hasMatch(value)) {
    return null;
  } else {
    return "El nombre ingresado es incorrecto";
  }
}

String lastNameValidator(String value) {
  if (value.isEmpty) return 'Debes ingresar tus apellidos';
  if (value.length < 2) return null;

  if (RegExp(
          r"^[a-zA-ZÀ-ÿ\u00f1\u00d1]+(\s*[a-zA-ZÀ-ÿ\u00f1\u00d1]*)*[a-zA-ZÀ-ÿ\u00f1\u00d1]+$")
      .hasMatch(value)) {
    return null;
  } else {
    return "El apellido ingresado es incorrecto";
  }
}

String addressValidator(String value) {
  if (value.isEmpty) return 'Debes ingresar una dirección';
  //if (value.length < 4) return 'Campo tiene que tener al menos 4 caracteres';

  return null;
}

String ccvValidator(String value) {
  if (value.isEmpty) return 'Debes ingresar el CCV de tu tarjeta';

  if (value.length < 3) return 'El CCV no es válido';

  return null;
}

String cardValidator(String value) {
  if (value.isEmpty) return 'Debes ingresar el número de tu tarjeta';

  if (value.length != 16) return 'El número de la tarjeta no es válido';

  return null;
}

String dateValidator(String value) {
  if (value.isEmpty) return 'Debes ingresar la fecha de caducidad';

  if (value.length < 7) return 'La fecha de caducidad no es válida';

  return null;
}

String phoneValidator(String value) {
  if (value.isEmpty) return 'Debes ingresar tu teléfono';

  if ((RegExp(r'^[0-9]+$').hasMatch(value) && value.length == 10)) {
    return null;
  } else {
    return 'El teléfono no es válido';
  }
}

bool visaValidator(String value) {
  if ((RegExp(r'^4[0-9]{6,}$').hasMatch(AppConverter.removeEmpty(value)))) {
    return true;
  } else {
    return false;
  }
}

bool masterCardValidator(String value) {
  if ((RegExp(
          r'^5[1-5][0-9]{5,}|222[1-9][0-9]{3,}|22[3-9][0-9]{4,}|2[3-6][0-9]{5,}|27[01][0-9]{4,}|2720[0-9]{3,}$')
      .hasMatch(AppConverter.removeEmpty(value)))) {
    return true;
  } else {
    return false;
  }
}
