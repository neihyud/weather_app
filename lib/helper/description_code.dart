import 'package:flutter/material.dart';

Widget getDesCode(String _code) {
  String text;
  var code = int.parse(_code);
  // var code = _code;
  switch (code) {
    case 0:
      text = ('Quang đãng');
      break;
    case 1:
    case 2:
    case 3:
      text = ('Mây và nắng');
      break;
    case 45:
    case 48:
      text = ('Sương mù');
      break;

    case 51:
    case 53:
    case 55:
      text = ('Mưa phùn');
      break;

    case 56:
    case 57:
      text = ('Mưa phùn băng giá');
      break;

    case 61:
    case 63:
    case 65:
      text = ('Mưa nhẹ');
      break;

    case 66:
    case 67:
      text = ('Mưa đá');
      break;

    case 71:
    case 73:
    case 75:
      text = ('Tuyết rơi');
      break;

    case 77:
      text = ('Tuyết');
      break;

    case 80:
    case 81:
    case 82:
      text = ('Mưa rào');
      break;

    case 85:
    case 86:
      text = ('Mưa tuyết nhẹ và nặng hạt');
      break;

    case 95:
      text = ('Giông bão');
      break;

    case 96:
    case 99:
      text = ('Giông bão với mưa đá nhỏ');
      break;
    default:
      text = ('Nắng');
  }

  return Text(text, style: TextStyle(fontWeight: FontWeight.w700));
}
  