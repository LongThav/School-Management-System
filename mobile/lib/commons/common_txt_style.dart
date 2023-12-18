import 'package:flutter/material.dart';

class CommonTxtStyle extends StatelessWidget {
  final String label;
  final Color? color;
  final double? fontSize;
  const CommonTxtStyle({super.key, this.color, this.fontSize, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
      ),
    );
  }
}
