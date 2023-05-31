import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  const MyText({
    super.key,
    this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlig,
  });
  final String? text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlig;

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: textAlig,
      style:
          TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
