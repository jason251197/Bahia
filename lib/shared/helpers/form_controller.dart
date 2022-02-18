import 'package:flutter/material.dart';

class FormController {
  static final nameController = TextEditingController();
  static final lastNController = TextEditingController();
  static final phoneController = TextEditingController();

  static final emailController = TextEditingController();
  static final emailForgotController = TextEditingController();

  static final passwordController = TextEditingController();
  static final password2Controller = TextEditingController();
  static final password3Controller = TextEditingController();

  static final numberCardEvents = TextEditingController();
  static final ccvController = TextEditingController();
  static final nameCardEvents = TextEditingController();
  static final dateCardEvents = TextEditingController();

  static final billController = TextEditingController();

  static final codeCouponController = TextEditingController();

  static void clean() {
    cleanController(nameController);
    cleanController(lastNController);

    cleanController(emailController);
    cleanController(emailForgotController);

    cleanController(passwordController);
    cleanController(password2Controller);
    cleanController(password3Controller);

    cleanController(phoneController);
    cleanController(numberCardEvents);
    cleanController(ccvController);
    cleanController(nameCardEvents);
    cleanController(dateCardEvents);

    cleanController(codeCouponController);
  }

  static void cleanController(TextEditingController controller) {
    controller.text = "";
  }
}
