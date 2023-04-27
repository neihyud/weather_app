import 'package:flutter/material.dart';
import 'package:weather_app/helper/description_code.dart';

Widget currentWeather(des, temp, location) {
  return Container(
    height: 180,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      // const Color.fromARGB(50, 56, 66, 82),
      color: const Color.fromARGB(35, 255, 255, 255),
    ),
    padding: const EdgeInsets.all(10),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // getDesCode((des).toString()),
          Text(
            "$location",
            style: const TextStyle(color: Colors.white, fontSize: 25),
          ),
          Text(
            "${temp.toString()} °C",
            style: const TextStyle(
                fontSize: 60, fontWeight: FontWeight.w800, color: Colors.white),
          ),
        ]),
  );
}
