import 'package:flutter/material.dart';

Widget getDesCode(String code) {
  String text;
  // var code = _code;
  switch (code) {
    case "0":
      text = ('Quang đãng');
      break;
    default:
      text = ('Nắng');
  }

  return Text(text, style: TextStyle(fontWeight: FontWeight.w700));
}
  