import 'package:flutter/material.dart';
import 'package:weather_app/helper/description_code.dart';

Widget currentWeather(des, temp, location) {
  return Container(
    height: 180,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: const Color.fromARGB(50, 56, 66, 82),
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
