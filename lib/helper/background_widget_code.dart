import 'package:flutter/material.dart';

Color getBackgroundWColor(String code) {
  Color colors;

  // if (code.isNotEmpty && code.substring(code.length - 1) == 'n') {
  //   return const Color(0xff455e7d);
  // }

  if (code.isNotEmpty) {
    code = code.substring(0, code.length - 1);
  }

  // night - quang
  //  return const Color(0xff3167a7);
  //
  // night - nhieu may
  //  return const Color(0xff455e7d); 

  switch (code) {
    case "01": // day: sun, quang
      colors = const Color(0xff619ce0);
      break;
    case "02":
      colors = const Color(0xff87a0c9);
      break;
    case "03": // nhieu may
      colors = const Color(0xff87a0c9);
      break;
    case "04":
      colors = const Color(0xff87a0c9);
      break;
    case "09": // mua
      colors = const Color(0xff455e7d);
      break;
    case "10": // mua
      colors = const Color(0xff455e7d);
      break;
    case "11": // giong - chua tim thay
      colors = const Color(0xff455e7d);
      break;
    case "13":
      colors = const Color(0xff87a0c9);
      break;
    case "50":
      colors = const Color(0xff455e7d);
      break;
    default:
      colors = const Color(0xff619ce0);
  }

  return colors;
}
