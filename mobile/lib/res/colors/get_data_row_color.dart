import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Color GetDataRowColor(Set<MaterialState> states) {
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
