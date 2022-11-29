import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final bool showInputDecoration;
  final String? hintText, helperText, errorText;
  final TextEditingController? controller;
  final Function(String)? onChange;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;

  const InputField({Key? key,
    this.showInputDecoration = true,
    this.onChange,
    this.controller,
    this.errorText,
    this.helperText,
    this.hintText,
    this.keyboardType,
    this.prefixIcon,
    this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      decoration: showInputDecoration
          ? InputDecoration(
          contentPadding:
          const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          hintText: hintText,
          helperText: helperText,
          errorText: errorText,
          prefixIcon: prefixIcon
      )
          : null,
      onChanged: onChange,
    );
  }
}
