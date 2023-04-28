import 'package:flutter/material.dart';

List<Color> getBackgroundColor(String code) {
  List<Color> colors;
  switch (code) {
    case "01d": // day: sun, quang
      colors = [
        const Color(0xff0973D1),
        const Color(0xff6ba5e4),
      ];
      break;
    case "02d": // night
      colors = [
        const Color(0xff2c3b60),
        const Color(0xff4a6583),
      ];
      break;
    case "02d": // nhieu may
      colors = [
        const Color(0xff577eb7),
        const Color(0xff8fa8cd),
      ];
      break;

    case "01d": // mua
      colors = [
        const Color(0xff566783),
        const Color(0xff7a8a99),
      ];
      break;
    case "01d": // suong mu
      colors = [
        const Color(0xff929292),
        const Color(0xff504f4d),
      ];
      break;
    default:
      colors = [
        const Color(0xff0973D1),
        const Color(0xff6ba5e4),
      ];
  }

  return colors;
}
