import 'package:flutter/material.dart';
import '../util/font_manager.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final String? Function(String?)? validate;
  final IconData suffixIcon;
  TextInputType? keyboardType;
  final bool obscureText;
  InputDecoration? decoration;

  CustomTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.isPassword,
      required this.obscureText,
      this.keyboardType,
      this.decoration,
      required this.validate,
      required this.suffixIcon});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: FontManager.getMediumStyle(fontSize: 16, color: Colors.black),
      obscureText: _passwordVisible,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      validator: widget.validate,
      decoration: widget.decoration ??
          InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical:18.0,horizontal: 10),
            hintText: widget.hintText,
            suffixIcon: Icon(
              widget.suffixIcon,
              color: Colors.black,
              size: 22,
            ),
          ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }
}
