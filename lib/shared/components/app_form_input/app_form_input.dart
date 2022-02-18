import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
export '../../helpers/input_validator.dart';

class FormInput extends StatefulWidget {
  const FormInput({
    this.controller,
    Key key,
    this.onChange,
    this.validator,
    this.focusNode,
    this.obscureText = false,
    this.icon,
    this.hintText,
    this.inputFormatters,
    this.textInputType,
    this.border,
    this.contentPadding,
    this.textInputAction,
    this.initialText,
    this.onEditingComplete,
    this.suffixIcon,
    this.textCapitalization,
  }) : super(key: key);

  final TextEditingController controller;
  final Function(String) onChange;
  final String Function(String) validator;
  final FocusNode focusNode;
  final bool obscureText;
  final Widget icon;
  final String hintText;
  final TextInputType textInputType;
  final List<TextInputFormatter> inputFormatters;
  final OutlineInputBorder border;
  final EdgeInsets contentPadding;
  final TextInputAction textInputAction;
  final String initialText;
  final Function onEditingComplete;
  final Widget suffixIcon;
  final TextCapitalization textCapitalization;

  @override
  _FormInputState createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  TextEditingController _controller;
  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    _controller.text = widget.initialText ?? '';

    super.initState();
  }

  _onChange(String text) =>
      widget.onChange is Function ? widget.onChange(text) : null;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      inputFormatters: widget.inputFormatters ?? [],
      onChanged: _onChange,
      autocorrect: false,
      keyboardType: widget.textInputType,
      focusNode: widget.focusNode,
      obscureText: widget.obscureText ?? false,
      onEditingComplete: widget.onEditingComplete,
      validator: widget.validator,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
      decoration: InputDecoration(
        focusedBorder: widget.border,
        border: widget.border,
        hintText: widget.hintText,
        contentPadding: widget.contentPadding,
        suffixIcon: widget.suffixIcon is Widget
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                //crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [widget.suffixIcon])
            : null,
        prefixIcon: widget.icon is Widget
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [widget.icon])
            : null,
      ),
    );
  }
}
