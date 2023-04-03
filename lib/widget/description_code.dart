import 'package:flutter/material.dart';

Widget getDesCode(String _code) {
  Text text;
  var code = int.parse(_code);
  // var code = _code;
  switch (code) {
    case 0:
      text = Text('Quang đãng');
      break;
    case 1:
    case 2:
    case 3:
      text = Text('Mây và nắng');
      break;
    case 45:
    case 48:
      text = Text('Sương mù');
      break;

    case 51:
    case 53:
    case 55:
      text = Text('Mưa phùn');
      break;

    case 56:
    case 57:
      text = Text('Mưa phùn băng giá');
      break;

    case 61:
    case 63:
    case 65:
      text = Text('Mưa nhẹ');
      break;

    case 66:
    case 67:
      text = Text('Mưa đá');
      break;

    case 71:
    case 73:
    case 75:
      text = Text('Tuyết rơi');
      break;

    case 77:
      text = Text('Tuyết');
      break;

    case 80:
    case 81:
    case 82:
      text = Text('Mưa rào');
      break;

    case 85:
    case 86:
      text = Text('Mưa tuyết nhẹ và nặng hạt');
      break;

    case 95:
      text = Text('Giông bão');
      break;

    case 96:
    case 99:
      text = Text('Giông bão với mưa đá nhỏ');
      break;
    default:
      text = Text('Nắng');
  }

  return text;
}
