import 'package:appclientes/shared/common.dart';
import 'package:appclientes/shared/components/app_button_switch/switch_option.dart';
import 'package:appclientes/v_home/controller/index.dart';
import 'package:flutter/material.dart';

import 'switch_buttons.dart';

class SearchTypes extends StatefulWidget {
  const SearchTypes({
    Key key,
  }) : super(key: key);

  @override
  _SearchTypesState createState() => _SearchTypesState();
}

class _SearchTypesState extends State<SearchTypes> {
  final num _paddingHBody = 10.0;

  bool _buildSearch = false;
  bool _showButtons = true;

  void onChange() async {
    final isClosing = _buildSearch;
    if (isClosing) HomeEvents.cleanSearch;

    setState(() {
      if (!isClosing) _showButtons = false;
      _buildSearch = !_buildSearch;
    });

    if (isClosing)
      await Future.delayed(Duration(milliseconds: 201), () {
        setState(() => _showButtons = true);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _paddingHBody, vertical: 5),
      child: Row(
        children: [
          _buildIcon(),
          // if (!_buildSearch) Spacer(),
          Spacer(),
          if (_showButtons) SwitchTypes(),
          Spacer(),
          if (_showButtons) SwitchOrderOption(),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return GestureDetector(
      onTap: () => onChange(),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: _buildSearch ? 50 : 40,
        width: MediaQuery.of(context).size.width * (_buildSearch ? 0.94 : 0.14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.graySoft1,
        ),
        padding: EdgeInsets.symmetric(horizontal: _paddingHBody, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_buildSearch)
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Input(
                  hintText: "Buscar",
                  textInputAction: TextInputAction.search,
                  onSubmit: HomeEvents.onSearch,
                ),
              )),
            AppIcon.path(_buildSearch ? AppIcon.close : AppIcon.lookup,
                height: 15.0),
          ],
        ),
      ),
    );
  }
}
