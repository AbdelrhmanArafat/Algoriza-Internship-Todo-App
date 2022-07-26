import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color textColor;
  final FontWeight textWeight;
  final double textSize;

  const TextWidget({
    Key? key,
    required this.text,
    this.textColor = Colors.black,
    this.textWeight = FontWeight.bold,
    this.textSize = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: textColor,
        fontWeight: textWeight,
        fontSize: textSize,
      ),
    );
  }
}
