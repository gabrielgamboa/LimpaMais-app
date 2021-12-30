import 'package:flutter/material.dart';

class TextInfo extends StatelessWidget {
  final String text;
  final double fontSize;

  const TextInfo({ Key? key, required this.text, this.fontSize = 16 }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize),
    );
  }
}