import 'package:flutter/material.dart';

class MyTextFromFiled extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? type;
  final GestureTapCallback? onTap;
  final String hintText;
  final Widget? suffix;
  final double radius;
  final String validator;
  final bool readOnly;

  const MyTextFromFiled({
    Key? key,
    this.controller,
    this.type,
    required this.hintText,
    this.radius = 12,
    required this.validator,
    this.onTap,
    this.suffix,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      onTap: onTap,
      readOnly: readOnly,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        hintText: hintText,
        suffixIcon: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
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
