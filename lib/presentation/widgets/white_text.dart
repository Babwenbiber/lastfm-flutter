import 'package:flutter/material.dart';

class WhiteText extends StatelessWidget {
  final String text;
  final double? fontSize;

  const WhiteText(this.text, {Key? key, this.fontSize}) : super(key: key);
  @override
  Widget build(BuildContext context) => Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: fontSize),
        maxLines: 5,
      );
}
