import 'package:flutter/material.dart';

Widget getIcon(String code, {double size = 28}) {
  return Image.asset(
    "assets/img/$code.png",
    height: 50,
    width: 50,
  );
}
