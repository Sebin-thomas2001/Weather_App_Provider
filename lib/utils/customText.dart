import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontsize;
  final Color color;
  final String? fontFamily;
  final FontWeight fontWeight;
  final bool isBold;
  final TextAlign textAlign;
  final double lineSpacing;
  const CustomText(
      {super.key,
      required this.text,
      this.fontsize = 14,
      this.color = Colors.black,
      this.fontFamily,
      this.fontWeight=FontWeight.normal,
      this.isBold = false,
      this.textAlign = TextAlign.left,
      this.lineSpacing = 0});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontsize,
          color: color,
          letterSpacing: lineSpacing,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
    );
  }
}
