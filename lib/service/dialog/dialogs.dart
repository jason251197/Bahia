part of 'dialog_service.dart';

class Dialogs {
  static DialogCard onChangeAddress() {
    return DialogCard(
      "Cambio de dirección",
      body: Column(
        children: [
          Texts.blackBold("¿Estás seguro que quieres\ncambiar de dirección?",
              textAlign: TextAlign.center),
          SizedBox(height: 10),
          Texts.black("Si sales perderás los productos\nque has seleccionado",
              textAlign: TextAlign.center),
        ],
      ),
      secondaryButton: DialogButton("cancelar", boolean: false),
      button: DialogButton("Aceptar", boolean: true),
    );
  }

  static DialogCard selectProduct() {
    return DialogCard("Selección de platos",
        body: Column(
          children: [
            Texts.black("Tu producto se agrego al carrito de compras",
                textAlign: TextAlign.left),
          ],
        ),
        icon: Icon(
          Icons.info,
          color: AppColors.gray,
          size: 50,
        ),
        secondaryButton: DialogButton("continuar comprado"),
        button: DialogButton(
          "Ir al carrito",
          onPress: () => NavController.goToCart(),
        ));
  }

  static DialogCard notAddAddressDialog() {
    return DialogCard("Dirección ya existe",
        body: Column(
          children: [
            Texts.black("No se pudo guardar.\nLa dirección ya existe.",
                textAlign: TextAlign.center),
            //Texts.blackBold(""),
          ],
        ),
        button: DialogButton("aceptar"));
  }

  static Future<DialogCard> addressNotFound() async {
    return DialogCard(
      "Dirección no válida",
      body: Padding(
        padding: EdgeInset.horizontal(10.0),
        child: Column(
          children: [
            Texts.black(
                "La dirección no es válida.\n Puede hacer uso del mapa o búsqueda para una mejor precisión.",
                textAlign: TextAlign.center),
            SizedBox(height: 10),
          ],
        ),
      ),
      // textButton: TxtButton("Cancelar"),
      button: DialogButton(
        "Aceptar",
        // onPress: () async {
        //   await openAppSettings();
        // },
      ),
    );
  }

  static Future<DialogCard> onMissingPermissions() async {
    return DialogCard(
      "Permisos de ubicación requeridos",
      body: Column(
        children: [
          Texts.blackBold(
            "¡Hola!",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Texts.black(
            "Por favor, activa los permisos de\n ubicación",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 0),
        ],
      ),
      textButton: TxtButton("Cancelar"),
      button: DialogButton(
        "Aceptar",
        onPress: () async {
          await openAppSettings();
        },
      ),
    );
  }

  /*
  static DialogCard confirmOrderPickUp(String msg) {
    return DialogCard("Confirmación de orden",
        body: Column(
          children: [
            Texts.black(
                "Tu pedido se ha enviado.\nPuedes recogerlo hasta las " +
                    msg +
                    " horas",
                textAlign: TextAlign.left),
            SizedBox(height: 10),
          ],
        ),
        icon: Icon(
          Icons.info,
          color: AppColors.gray,
          size: 50,
        ),
        button: DialogButton("Aceptar", onPress: NavController.goToHome));
  }
  */
  static DialogCard confirmOrderPickUp(String msg) {
    return DialogCard("Confirmación de orden",
        body: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Column(
                children: [
                  Icon(
                    Icons.info,
                    color: AppColors.gray,
                    size: 40,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Texts.black(
                    "Tu pedido se procesó correctamente.\nRecuerda que tienes hasta las " +
                        msg +
                        "\nhoras para recogerlo.\nMira el detalle completo en tu correo.",
                    textAlign: TextAlign.left),
              ],
            ),
          ],
        ),
        button: DialogButton("Aceptar", onPress: NavController.goToHome));
  }
  /*
  static DialogCard confirmOrderDelivery(String msg) {
    return DialogCard("Confirmación de orden",
        body: Column(
          children: [
            Texts.black(
                "Su pedido se ha enviado\nLlegaremos entre " + msg + " minutos. Revisa el detalle en tu correo.",
                textAlign: TextAlign.left),
            SizedBox(height: 10),
          ],
        ),
        icon: Icon(
          Icons.info,
          color: AppColors.gray,
          size: 50,
        ),
        button: DialogButton("Aceptar", onPress: NavController.goToHome));
  }
  */

  static DialogCard confirmOrderDelivery(String msg) {
    return DialogCard("Confirmación de orden",
        body: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Column(
                children: [
                  Icon(
                    Icons.info,
                    color: AppColors.gray,
                    size: 40,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Texts.black(
                    "Tu pedido se procesó correctamente.\nLlegaremos entre " +
                        msg +
                        " minutos.\nMira el detalle completo en tu correo.",
                    textAlign: TextAlign.left),
              ],
            ),
          ],
        ),
        button: DialogButton("Aceptar", onPress: NavController.goToHome));
  }

  static DialogCard confirmOrder(String msg) {
    return DialogCard("Confirmación de orden",
        body: Column(
          children: [
            Texts.black(msg, textAlign: TextAlign.left),
            SizedBox(height: 10),
          ],
        ),
        icon: Icon(
          Icons.info,
          color: AppColors.gray,
          size: 50,
        ),
        button: DialogButton("Aceptar", onPress: NavController.goToHome));
  }

  static DialogCard registerBeforeBuy() {
    return DialogCard("Registrate",
        body: Column(
          children: [
            Texts.black("Por favor, regístrate\npara completar la compra",
                textAlign: TextAlign.left),
            SizedBox(height: 10),
          ],
        ),
        icon: Icon(
          Icons.info,
          color: AppColors.gray,
          size: 50,
        ),
        button: DialogButton(
          "Registrarme",
          onPress: () {
            NavController.goToLoginOnPayment();
          },
        ));
  }

  static DialogCard registerBeforeUpdate() {
    return DialogCard("Registrate",
        body: Column(
          children: [
            Texts.black("Por favor, regístrate\npara modificar tu cuenta",
                textAlign: TextAlign.left),
            SizedBox(height: 10),
          ],
        ),
        icon: Icon(
          Icons.info,
          color: AppColors.gray,
          size: 50,
        ),
        textButton: TxtButton('Cancelar'),
        button: DialogButton(
          "Registrarme",
          onPress: () {
            NavController.goToLogin();
          },
        ));
  }

  static DialogCard cancelMyOrder() {
    return DialogCard("Anular mi último pedido",
        body: Column(
          children: [
            Texts.blackBold("¿Seguro que quieres anular el pedido?",
                textAlign: TextAlign.center),
            SizedBox(height: 10),
            Texts.black(
                "Te devolveremos el dinero, pero este plato terminará en la basura, recuerda que siempre puedes regalarlo",
                textAlign: TextAlign.center),
          ],
        ),
        textButton: TxtButton("Aceptar"),
        button: DialogButton("cancelar"));
  }

  static DialogCard deleteAddress() {
    return DialogCard(
      "Eliminar la Dirección",
      body: Column(
        children: [
          Texts.blackBold("¿Estas seguro que deseas eliminar \nesta dirección?",
              textAlign: TextAlign.center),
          SizedBox(height: 10),
        ],
      ),
      secondaryButton: DialogButton("cancelar", boolean: false),
      button: DialogButton("Aceptar", boolean: true),
    );
  }

  static DialogCard closeOrders() {
    return DialogCard("Notificación",
        body: Padding(
          padding: const EdgeInsets.only(bottom: 25.0),
          child: Column(
            children: [
              Texts.blackBold("¿Estás seguro que quieres salir?",
                  textAlign: TextAlign.left),
              Texts.black(
                  "Si sales perderás los productos que has seleccionado",
                  textAlign: TextAlign.left),
            ],
          ),
        ),
        icon: Icon(
          Icons.info,
          color: AppColors.gray,
          size: 50,
        ),
        secondaryButton: DialogButton(
          "Salir",
          width: 150,
          onPress: () {
            CartState().clean;
            CouponState().clean;
            NavController.goToHome();
          },
        ),
        button: DialogButton(
          "Quedarme",
          width: 150,
        ));
  }

  static DialogCard closeAccountDialog() {
    return DialogCard("Eliminar mi Cuenta",
        body: Column(
          children: [
            Texts.black(
                "Para gestionar la baja de tu cuenta\nenvíanos un correo a",
                textAlign: TextAlign.center),
            Texts.blackBold("clientes@planetoliver.com"),
          ],
        ),
        button: DialogButton("aceptar"));
  }

  static DialogCard contactUsDialog() {
    return DialogCard("Contáctanos",
        body: Column(
          children: [
            Texts.black("Puedes comunicarte con nosotros al correo"),
            Texts.blackBold("clientes@planetoliver.com"),
          ],
        ),
        button: DialogButton("aceptar"));
  }

  static DialogCard logout() {
    return DialogCard(
      "Cerrar Sesión",
      body: Column(
        children: [
          Texts.blackBold("¿Estás seguro que deseas cerrar sesión?",
              textAlign: TextAlign.center),
          SizedBox(height: 10),
        ],
      ),
      secondaryButton: DialogButton("No", boolean: false),
      button: DialogButton("Si", boolean: true),
    );
  }

  static DialogCard simpleDialog(String message) {
    return DialogCard("Aviso",
        body: Column(
          children: [
            Padding(
              padding: EdgeInset.horizontal(10.0),
              child: Texts.black(message ?? "", textAlign: TextAlign.center),
            ),
          ],
        ),
        button: DialogButton("aceptar"));
  }

  static DialogCard yesNoDialog(String message) {
    return DialogCard("Aviso",
        body: Column(
          children: [
            Padding(
              padding: EdgeInset.horizontal(10.0),
              child: Texts.black(message ?? "", textAlign: TextAlign.center),
            ),
          ],
        ),
        secondaryButton: DialogButton("cancelar", boolean: false),
        button: DialogButton("aceptar", boolean: true));
  }

  static DialogCard validateProductStockMyOrder() {
    return DialogCard("Stock no disponible",
        body: Column(
          children: [
            SizedBox(height: 10),
            Texts.black("Ya no existe stock disponible",
                textAlign: TextAlign.center),
          ],
        ),
        button: DialogButton("Aceptar"));
  }

  static DialogCard validateLocation() {
    return DialogCard("Seleccionar Dirección",
        body: Column(
          children: [
            SizedBox(height: 10),
            Texts.black("Seleccione una Dirección",
                textAlign: TextAlign.center),
          ],
        ),
        button: DialogButton("Aceptar"));
  }

  static DialogCard deleteCard() {
    return DialogCard(
      "Eliminar la Tarjeta",
      body: Column(
        children: [
          Texts.blackBold("¿Estas seguro que deseas eliminar \nesta tarjeta?",
              textAlign: TextAlign.center),
          SizedBox(height: 10),
        ],
      ),
      secondaryButton: DialogButton("cancelar", boolean: false),
      button: DialogButton("Aceptar", boolean: true),
    );
  }

  static DialogCard cancelOrder(String msg) {
    return DialogCard("Aviso",
        body: Column(
          children: [
            Texts.black("¿Está seguro de querer cancelar el pedido?",
                textAlign: TextAlign.left),
            SizedBox(height: 10),
          ],
        ),
        icon: Icon(
          Icons.info,
          color: AppColors.gray,
          size: 50,
        ),
        secondaryButton: DialogButton("cancelar", boolean: false),
        button: DialogButton("Aceptar",
            onPress: NavController.goToHome, boolean: true));
  }

  static DialogCard updateMe() {
    return DialogCard(
      "Nueva versión Oliver",
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Texts.black(
                "Se encontró una nueva versión del app Planet Oliver, pulsa actualizar para descargar.",
                textAlign: TextAlign.center),
          ),
          SizedBox(height: 5),
        ],
      ),
      button: DialogButton(
        "Actualizar",
        doPop: false,
        onPress: () => Platform.isAndroid ? openPlayStore() : openAppStore(),
      ),
    );
  }

  static void openPlayStore() =>
      LauncherService.launchURL(AppURLs.PLAY_STORE_URL);

  static void openAppStore() =>
      LauncherService.launchURL(AppURLs.APP_STORE_URL);
}
