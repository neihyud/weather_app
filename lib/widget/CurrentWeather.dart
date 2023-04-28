import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/helper/des_weather_code.dart';

Widget currentWeather(code, temp) {
  return Container(
    height: 250,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      // const Color.fromARGB(50, 56, 66, 82),
      // color: const Color.fromARGB(35, 255, 255, 255),
    ),
    padding: const EdgeInsets.all(10),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/cloudy-clear.svg',
            alignment: Alignment.center,
          ),
          Text(
            temp.toString(),
            style: const TextStyle(
                fontSize: 100,
                fontWeight: FontWeight.w400,
                color: Colors.white),
          ),
          getDesCode('$code')
        ]),
  );
}
