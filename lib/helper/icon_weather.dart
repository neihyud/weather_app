import 'package:flutter/material.dart';

Widget getIcon(String code, {double size = 28}) {
  Image imgIcon;
  switch (code) {
    case "0":
      imgIcon = Image.asset(
        "assets/img/50d.png",
        height: 40,
        width: 40,
      );
      break;
    
    default:
      imgIcon = Image.asset(
        "assets/img/01d.png",
        height: 40,
        width: 40,
      );
  }

  return imgIcon;
}
