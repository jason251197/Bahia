import 'package:appclientes/shared/components/app_gray_top_header/gray_top_header.dart';
import 'package:flutter/material.dart';
import '../app_bar/app_bar.dart';

class AppView extends StatelessWidget {
  final bool resize;
  final Color backgroundColor;
  final Widget child;
  final Widget appBar;
  final Widget bottomNavigation;
  final bool blockExpanded;
  final bool back;

  const AppView({
    this.resize = true,
    this.child,
    this.backgroundColor,
    this.back,
    this.appBar,
    this.bottomNavigation,
    this.blockExpanded = false,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      resizeToAvoidBottomInset: resize,
      bottomNavigationBar: bottomNavigation,
      appBar: appBar,
      body: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: blockExpanded
            ? child ?? Container()
            : Column(
                children: [
                  Expanded(
                    child: child ?? Container(),
                  )
                ],
              ),
      ),
    );
  }
}

class AppContainer extends StatelessWidget {
  final Widget child;
  final String text;
  final String bottomText;
  final Function back;
  final Widget grayHeader;
  final Widget bottomNavigation;
  final bool resize;
  final bool blockRedirect;

  const AppContainer({
    Key key,
    this.child,
    this.text,
    this.bottomText,
    this.back,
    this.grayHeader,
    this.resize = true,
    this.bottomNavigation,
    this.blockRedirect = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppView(
      resize: resize,
      bottomNavigation: bottomNavigation,
      child: Column(
        children: [
          AppTopBar(
            back: back,
            body: grayHeader,
            bottomText: bottomText,
            text: text,
            blockRedirect: blockRedirect,
            // key: AppKeys.cardFormKey,
          ),
          Expanded(child: child ?? Container()),
        ],
      ),
    );
  }
}

class AppPage extends StatelessWidget {
  final Widget child;
  final String text;
  final String bottomText;
  final Function back;
  final Widget grayHeader;
  final Widget bottomNavigation;
  final bool resize;

  const AppPage({
    this.child,
    this.text,
    this.bottomText,
    this.back,
    this.grayHeader,
    this.resize = true,
    this.bottomNavigation,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          GrayTopHeader(
            // back: back,
            text: text,
            child: child,
          ),
          Expanded(child: child ?? Container()),
        ],
      ),
    );
  }
}

class AppViews {
  static Widget localitation(
          {Widget child, Function onBack, bool block = false}) =>
      AppContainer(
        text: "Localización",
        back: onBack,
        bottomText: onBack is Function
            ? "Agregar nueva dirección"
            : "Agregar dirección",
        resize: false,
        blockRedirect: block,
        child: child ?? Container(),
      );

  static Widget addCard({Widget child, Function onBack}) => AppContainer(
        text: "Mi cuenta",
        back: onBack,
        bottomText: "Agregar nueva tarjeta",
        child: child ?? Container(),
      );

  static Widget common({
    Widget child,
    Function back,
    String text,
  }) =>
      Expanded(
        child: Column(
          children: [
            GrayTopHeader(
              back: back,
              text: text,
            ),
            Expanded(child: child ?? Container()),
          ],
        ),
      );
}
