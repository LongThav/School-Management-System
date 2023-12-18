import 'package:flutter/material.dart';

import '../res/colors/color.dart';
import 'common_txt_style.dart';

class CommonStart extends StatelessWidget {
  final String label;
  const CommonStart({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(color: btnColor, borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: CommonTxtStyle(
          fontSize: 15,
          label: label,
          color: Colors.white,
        ),
      ),
    );
  }
}
