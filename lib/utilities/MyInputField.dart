import 'package:flutter/material.dart';

class MyInputField extends StatelessWidget {
  String labelText;
  bool isObscure;
  Color borderColor;
  IconData? icon;
  TextEditingController controller;

  MyInputField({
    Key? key,
    required this.labelText,
    required this.isObscure,
    required this.borderColor,
    required this.icon,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
      ),
      obscureText: isObscure,
    );
  }
}
