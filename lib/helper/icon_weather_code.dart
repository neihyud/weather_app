import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget getIconWeather(String code, int dt, {double size = 28}) {
  if (code.isNotEmpty) {
    code = code.substring(0, code.length - 1);
  }

  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(dt * 1000);

  int hour = dateTime.hour;

  if (hour < 5 || hour > 17) {
    code = '${code}n';
  } else {
    code = '${code}d';
  }

  switch (code) {
    case "01d":
      code = 'sun';
      break;
    case "01n":
      code = 'sun-n';
      break;
    case "02d":
      code = 'cloudy-clear';
      break;
    case "02n":
      code = 'cloudy-clear-n';
      break;
    case "03d":
      code = 'cloudy';
      break;
    case "03n":
      code = 'cloudy';
      break;
    case "04d":
      code = 'cloudy';
      break;
    case "04n":
      code = 'cloudy';
      break;
    case "09d":
      code = 'heavy-rain';
      break;
    case "09n":
      code = 'heavy-rain';
      break;
    case "10d":
      code = 'scattered-showers';
      break;
    case "10n":
      code = 'scattered-showers-n';
      break;
    case "11d":
      code = 'server-thunderstorm';
      break;
    case "11n":
      code = 'server-thunderstorm';
      break;
    case "13d":
      code = 'snow';
      break;
    case "13n":
      code = 'snow';
      break;
    case "50d":
      code = 'fog';
      break;
    case "50n":
      code = 'fog';
      break;
    default:
      code = 'sun';
  }
  return SvgPicture.asset(
    'assets/icons/$code.svg',
    alignment: Alignment.center,
  );
}
