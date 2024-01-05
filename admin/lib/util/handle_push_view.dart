import 'package:flutter/material.dart';

void pushView(BuildContext context, dynamic route){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>route));
}

void pushReplaceView(BuildContext context, dynamic route){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>route));
}

void popView(BuildContext context){
  Navigator.pop(context);
}