import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  const Input({
    Key key,
    this.onChange,
    this.onSubmit,
    this.focusNode,
    this.onEditingComplete,
    this.controller,
    this.icon,
    this.obscureText = false,
    this.suffixIcon,
    this.initialText,
    this.hintText,
    this.textInputAction,
  }) : super(key: key);

  final TextEditingController controller;
  final Function(String) onChange;
  final Function(String) onSubmit;
  final Function onEditingComplete;
  final FocusNode focusNode;
  final bool obscureText;
  final Widget icon;
  final Widget suffixIcon;
  final String initialText;
  final String hintText;
  final textInputAction;

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  TextEditingController _controller;
  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    _controller.text = widget.initialText ?? '';
    super.initState();
  }

  _onChange(String text) =>
      widget.onChange is Function ? widget.onChange(text) : null;
  _onSubmit(String text) =>
      widget.onSubmit is Function ? widget.onSubmit(text) : null;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: _onChange,
      onSubmitted: _onSubmit,
      onEditingComplete: widget.onEditingComplete,
      autocorrect: false,
      focusNode: widget.focusNode,
      obscureText: widget.obscureText,
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.icon is Widget
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [widget.icon])
            : null,
        suffix: widget.suffixIcon is Widget
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [widget.suffixIcon])
            : null,
      ),
    );
  }
}
