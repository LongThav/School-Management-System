import 'package:flutter/material.dart';

Color getDataRowColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.blue.withOpacity(0.5);
  }
  return Colors.transparent;
}
