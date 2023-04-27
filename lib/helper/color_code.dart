import 'package:flutter/material.dart';

List<Color> getColor(String code) {
  List<Color> colors;
  switch (code) {
    case "01d": // day: sun
      colors = [
        const Color.fromARGB(255, 99, 94, 223),
        const Color.fromARGB(255, 122, 154, 201),
      ];
      break;
    case "02d": // night
      colors = [
        const Color.fromARGB(255, 79, 108, 175),
        const Color.fromARGB(255, 102, 119, 160),
      ];
      break;
    case "02d": // rain
      colors = [
        Color.fromARGB(255, 53, 46, 122),
        Color.fromARGB(255, 87, 66, 131),
      ];
      break;
    case "01d": // rain
      colors = [
        Color.fromARGB(255, 82, 115, 148),
        Color.fromARGB(255, 114, 140, 150),
        // Color.fromARGB(255, 87, 66, 131),
      ];
      break;
    default:
      colors = [
        const Color.fromARGB(255, 99, 94, 223),
        const Color.fromARGB(255, 122, 154, 201),
      ];
  }

  return colors;
}
