import 'package:flutter/material.dart';

List<Color> getBackgroundColor(String code) {
  List<Color> colors;

  // if (code.isNotEmpty && code.substring(code.length - 1) == 'n') {
  //   return [
  //     const Color(0xff2c3b60),
  //     const Color(0xff4a6583),
  //   ];
  // }

  if (code.isNotEmpty) {
    code = code.substring(0, code.length - 1);
  }

  // night - quang
  //colors = [
  //  const Color(0xff051b62),
  //      const Color(0xff3672b1),
  // ];

  switch (code) {
    case "01": // day: sun, quang
      colors = [
        const Color(0xff0973D1),
        const Color(0xff6ba5e4),
      ];
      break;
    case "02": // nhieu may
      colors = [
        const Color(0xff577eb7),
        const Color(0xff8fa8cd),
      ];
      break;
    case "03": // nhieu may
      colors = [
        const Color(0xff577eb7),
        const Color(0xff8fa8cd),
      ];
      break;

    case "04": // nhieu may
      colors = [
        const Color(0xff577eb7),
        const Color(0xff8fa8cd),
      ];
      break;
    case "09": // mua
      colors = [
        const Color(0xff566783),
        const Color(0xff7a8a99),
      ];
      break;
    case "10": // mua
      colors = [
        const Color(0xff566783),
        const Color(0xff7a8a99),
      ];
      break;
    case "11": // giong - chua tthay
      colors = [
        const Color(0xff566783),
        const Color(0xff7a8a99),
      ];
      break;
    case "13": // tuyet - chua thay
      colors = [
        const Color(0xff577eb7),
        const Color(0xff8fa8cd),
      ];
      break;
    case "50": // suong mu
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
