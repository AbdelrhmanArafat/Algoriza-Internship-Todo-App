import 'package:flutter/material.dart';

class MyTextFromFiled extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final GestureTapCallback onTap;
  final String hintText;
  final IconData? suffix;
  final double radius;
  final String validator;

  const MyTextFromFiled({
    Key? key,
    required this.controller,
    required this.type,
    required this.hintText,
    this.radius = 10,
    required this.validator,
    required this.onTap,
    this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: Icon(suffix),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return validator;
        } else {
          return null;
        }
      },
    );
  }
}
