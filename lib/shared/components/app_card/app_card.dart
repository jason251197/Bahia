import 'package:appclientes/shared/common.dart';
import 'package:appclientes/v_profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';

class AppCard extends StatefulWidget {
  final String title;
  final Widget child;
  final bool buildOpen;
  final double paddingH;
  const AppCard({
    Key key,
    this.title,
    this.child,
    this.buildOpen = false,
    this.paddingH,
  }) : super(key: key);

  @override
  _AppCardState createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  bool _open;

  @override
  void initState() {
    _open = widget?.buildOpen ?? true;
    super.initState();
  }

  void onChange() {
    setState(() {
      _open = !_open;
    });
  }

  @override
  Widget build(BuildContext context) {
    return EdgeInset.appDecoration(
      radius: BorderRadius.all(Radius.circular(40)),
      child: Card(
        child: Column(
          children: [
            InkWell(
              onTap: onChange,
              child: Container(
                color: AppColors.graySoft2,
                child: EdgeInset.appPadding(
                  vertical: 14.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Texts.blackBold(
                          widget.title?.toUpperCase() ??
                              "datos de la cuenta".toUpperCase(),
                          fontSize: 15,
                          letterSpacing: 0.25),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AppIcon.path(
                          !_open ? AppIcon.add : AppIcon.remove,
                          height: 10.0,
                          width: 10.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_open)
              EdgeInset.appPadding(
                vertical: 10.0,
                horizontal: widget.title?.toUpperCase() == 'DATOS DE LA CUENTA' ? 2.0 : widget.paddingH,
                child: widget.child ??
                    Buttons.blue(
                      'Salir',
                      onClick: ProfileController.logout,
                    ),
              ),
          ],
        ),
      ),
    );
  }
}

class SimpleCard extends StatelessWidget {
  final String title;
  final Widget child;
  final double paddingH;
  const SimpleCard({
    Key key,
    this.title,
    this.child,
    this.paddingH,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EdgeInset.appDecoration(
      horizontal: paddingH,
      radius: BorderRadius.all(Radius.circular(40)),
      child: Card(
        child: Column(
          children: [
            EdgeInset.appPadding(
              vertical: 10.0,
              child: child ??
                  Buttons.blue(
                    'Salir',
                    onClick: ProfileController.logout,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardField extends StatelessWidget {
  final Widget child;
  final double paddingH;

  CardField({this.child, this.paddingH});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.graySoft2,
            ),
          ),
        ),
        child: EdgeInset.appPadding(
          vertical: 12.0,
          horizontal: paddingH ?? 5,
          child: child ?? Container(),
        ),
      ),
    );
  }
}

class SaveTag extends StatelessWidget {
  final Function onPress;
  final String text;
  final String icon;
  const SaveTag(
    this.text, {
    Key key,
    this.onPress,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: EdgeInset.appPadding(
        vertical: 15.0,
        horizontal: 0.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppIcon.path(icon ?? AppIcon.plus),
            SizedBox(width: 4),
            Texts.blackBold(text?.toUpperCase() ?? "text".toUpperCase(),
                fontSize: 17),
          ],
        ),
      ),
    );
  }
}
