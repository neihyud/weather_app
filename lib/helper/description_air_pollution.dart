import 'package:flutter/material.dart';

Widget getDesAirPopulation(String code) {
  String text;
  // var code = _code;
  switch (code) {
    case "1":
      text = ('Tốt');
      break;
    case "2":
      text = ('Khá');
      break;
    case "3":
      text = ('Trung bình');
      break;
    case "4":
      text = ('Kém');
      break;
    case "5":
      text = ('Rất kém');
      break;
    default:
      text = ('Tốt');
  }

  return Text(text,
      style: const TextStyle(
          fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white));
}
