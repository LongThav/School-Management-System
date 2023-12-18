import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class CommonBtn extends StatelessWidget {
  final String label;
  final Color color;
  final TextStyle textStyle;
  final Callback callback;
  final bool isLoading;
  const CommonBtn(
      {super.key,
      required this.label,
      required this.color,
      required this.textStyle,
      required this.callback, 
      required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Center(
          child: isLoading? const CircularProgressIndicator(color: Colors.white,) : Text(
            label,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
