import 'package:flutter/material.dart';

class QText extends StatelessWidget {
  const QText(this.text,
      {Key? key,
      this.color,
      this.size,
      this.weight,
      this.align,
      this.letterSpacing,
      this.wordSpacing,
      this.lineHeight})
      : super(key: key);

  final String text;
  final Color? color;
  final double? size;
  final FontWeight? weight;
  final TextAlign? align;
  final double? lineHeight;
  final double? letterSpacing;
  final double? wordSpacing;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: weight,
        height: lineHeight,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
      ),
    );
  }
}
