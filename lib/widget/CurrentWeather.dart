import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/helper/description_code.dart';

Widget currentWeather(des, temp) {
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
            "${temp.toString()}",
            style: const TextStyle(
                fontSize: 100,
                fontWeight: FontWeight.w400,
                color: Colors.white),
          ),
          Text(
            "$des",
            style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Colors.white70),
          )
        ]),
  );
}
