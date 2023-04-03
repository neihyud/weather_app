import 'package:flutter/material.dart';

Widget getIcon(String _code, {double size = 28}) {
  Image imgIcon;
  var code = int.parse(_code);
  switch (code) {
    case 0:
      imgIcon = Image.asset(
        "assets/img/50d.png",
        height: 40,
        width: 40,
      );
      break;
    case 1:
    case 2:
    case 3:
      imgIcon = Image.asset("assets/img/02d.png", height: 50, width: 50);
      break;
    case 45:
    case 48:
      imgIcon = Image.asset(
        "assets/img/01d.png",
        height: 40,
        width: 40,
      );
      break;

    case 51:
    case 53:
    case 55:
      imgIcon = Image.asset(
        "assets/img/09d.png",
        height: 40,
        width: 40,
      );
      break;

    case 56:
    case 57:
      imgIcon = Image.asset(
        "assets/img/01d.png",
        height: 40,
        width: 40,
      );
      break;

    case 61:
    case 63:
    case 65:
      imgIcon = Image.asset(
        "assets/img/01d.png",
        height: 40,
        width: 40,
      );
      break;

    case 66:
    case 67:
      imgIcon = Image.asset(
        "assets/img/01d.png",
        height: 40,
        width: 40,
      );
      break;

    case 71:
    case 73:
    case 75:
      imgIcon = Image.asset(
        "assets/img/drop_snow.png",
        height: 40,
        width: 40,
      );
      break;

    case 77:
      imgIcon = Image.asset(
        "assets/img/01d.png",
        height: 40,
        width: 40,
      );
      break;

    case 80:
    case 81:
    case 82:
      imgIcon = Image.asset(
        "assets/img/10d.png",
        height: 40,
        width: 40,
      );
      break;

    case 85:
    case 86:
      imgIcon = Image.asset(
        "assets/img/01d.png",
        height: 40,
        width: 40,
      );
      break;

    case 95:
      imgIcon = Image.asset(
        "assets/img/11d.png",
        height: 40,
        width: 40,
      );
      break;

    case 96:
    case 99:
      imgIcon = Image.asset(
        "assets/img/11d.png",
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
