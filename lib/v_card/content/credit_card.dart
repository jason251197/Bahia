import 'package:appclientes/shared/common.dart';
import 'package:flutter/material.dart';

class CreditCard extends StatefulWidget {
  final TextEditingController controller;

  const CreditCard({
    Key key,
    this.controller,
  }) : super(key: key);

  @override
  _CreditCardState createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  TextEditingController controller;
  String text = '';
  @override
  void initState() {
    if (widget.controller is TextEditingController)
      controller = widget.controller;

    if (controller is TextEditingController)
      controller.addListener(() {
        setState(() => text = widget.controller.text);
      });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (text.isNotEmpty)
      return EdgeInset.appDecoration(
        radius: BorderRadius.circular(20.0),
        color: AppColors.graySoft4,
        marginV: 20.0,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              AppIcon.path(AppIcon.getCardType(text), width: 100.0),
              Texts.black(
                  "* * * * ${text.length > 4 ? text.substring(text.length - 4) : ''}"),
            ],
          ),
        ),
      );
    return Container();
  }
}
