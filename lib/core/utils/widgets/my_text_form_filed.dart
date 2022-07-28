import 'package:flutter/material.dart';

class MyTextFromFiled extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? type;
  final GestureTapCallback? onTap;
  final String hintText;
  final Widget? suffix;
  final double radius;
  final String validator;
  final Widget? widget;

  const MyTextFromFiled({
    Key? key,
    this.controller,
    this.type,
    required this.hintText,
    this.radius = 10,
    required this.validator,
    this.onTap,
    this.suffix,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget == null ? false : true,
      autofocus: false,
      controller: controller,
      keyboardType: type,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffix,
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
