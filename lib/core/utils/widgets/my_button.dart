import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final double width;
  final double radius;
  final double height;
  final Color buttonColor;
  final VoidCallback onPressed;
  final String text;
  final Color textColor;
  final double textSize;

  const MyButton({
    Key? key,
    this.width = double.infinity,
    this.radius = 20,
    this.height = 56,
    this.buttonColor = Colors.green,
    required this.onPressed,
    required this.text,
    this.textColor = Colors.white,
    this.textSize = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        height: height,
        color: buttonColor,
        onPressed: onPressed,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: textSize,
            ),
          ),
        ),
      ),
    );
  }
}
