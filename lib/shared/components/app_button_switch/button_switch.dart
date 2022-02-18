import 'package:appclientes/service/api/api_service.dart';
import 'package:appclientes/shared/common.dart';
import 'package:appclientes/v_home/controller/index.dart';
import 'package:flutter/material.dart';

class Buttonswitch extends StatefulWidget {
  final Function(int) onSwitch;
  final List<String> buttons;
  final int indexSelected;
  const Buttonswitch({
    Key key,
    this.onSwitch,
    this.buttons,
    this.indexSelected,
  }) : super(key: key);

  @override
  _ButtonswitchState createState() => _ButtonswitchState();
}

class _ButtonswitchState extends State<Buttonswitch> {
  List<String> _buttonList;
  int _currentIndex;

  @override
  void initState() {
    _buttonList = widget.buttons ?? [];
    _currentIndex = widget.indexSelected ?? 0;
    super.initState();
  }

  void onChange(int index) async {
    if (await AppConnectivity.check()) {
      setState(() => _currentIndex = index);
      if (widget.onSwitch is Function) widget.onSwitch(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          color: AppColors.graySoft1,
          borderRadius: BorderRadius.circular(28.0)),
      child: Row(
        children: [
          ..._buttonList
              .asMap()
              .entries
              .map((e) => _buildButton(e.key, e.value)),
        ],
      ),
    );
  }

  Widget _buildButton(int index, String text) => StreamBuilder(
      stream: FilterState().isLoadingEvents,
      builder: (_, __) {
        final isLoading = FilterState().isLoading;

        return InkWell(
          onTap: () => isLoading ? null : onChange(index),
          child: Container(
            height: 40,
            alignment: Alignment.center,
            padding: EdgeInset.horizontal(10.0),
            decoration: BoxDecoration(
                color: index == _currentIndex
                    ? AppColors.yellow
                    : AppColors.graySoft1,
                borderRadius: BorderRadius.circular(28.0)),
            child: Texts.blackBold(text.toUpperCase(), fontSize: 12),
          ),
        );
      });
}
