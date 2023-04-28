import 'package:flutter/material.dart';

Widget getDesCode(String code) {
  String text;

  if (code.isNotEmpty) {
    code = code.substring(0, code.length - 1);
  }

  switch (code) {
    case "01":
      text = "Quang";
      break;
    case "02":
      text = "Nhiều mây";
      break;
    case "03":
      text = "Nhiều mây";
      break;
    case "04":
      text = "Nhiều mây";
      break;
    case "09":
      text = "Mưa";
      break;
    case "10":
      text = "Mưa";
      break;
    case "11":
      text = "Giông";
      break;
    case "13":
      text = "Tuyết";
      break;
    case "50":
      text = "Sương mù";
      break;

    default:
      text = "Quang";
  }

  return Text(
    text,
    style: const TextStyle(
        fontSize: 30, fontWeight: FontWeight.w500, color: Colors.white70),
  );
}
