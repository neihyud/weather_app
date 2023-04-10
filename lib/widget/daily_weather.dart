import 'dart:ffi';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import '../models/Weather.dart';
import 'icon_weather.dart';

Widget dailyWeather(Weather weather) {
  return Container(
    // height: 500,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: const Color.fromARGB(50, 56, 66, 82),
    ),
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 7,
        itemBuilder: (BuildContext context, index) {
          String? dateTime = weather.daily?.time?[index];
          DateTime daytime = DateTime.parse(dateTime!);

          String weekday = "${daytime.weekday}";

          String currentWeekday = "";

          switch (weekday) {
            case "1":
              currentWeekday = 'Monday';
              break;
            case "2":
              currentWeekday = 'Tuesday';
              break;
            case "3":
              currentWeekday = 'Wednesday';
              break;
            case "4":
              currentWeekday = 'Thursday';
              break;
            case "5":
              currentWeekday = 'Friday';
              break;
            case "6":
              currentWeekday = 'Saturday';
              break;
            case "7":
              currentWeekday = 'Sunday';
              break;

            default:
              currentWeekday = 'Err';
          }
          if (index == 0) {
            currentWeekday = "Today";
          }

          return day(
            currentWeekday,
            "${weather.daily?.weathercode?[index]}",
            "${weather.daily?.temperature2MMin?[index]}",
            "${weather.daily?.temperature2MMax?[index]}",
          );
        }),
  );
}

Widget day(String weekday, String code, String temp_min, String temp_max) {
  return SizedBox(
    height: 65,
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      SizedBox(
        width: 100,
        child: Text(weekday,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
      ),
      getIcon(code),
      Wrap(
        spacing: 12.0,
        children: [
          Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
            Text(
              "${double.parse(temp_min).round()}°",
              style: TextStyle(fontSize: 20),
            ),
            const Text("  /  ", style: TextStyle(fontSize: 20)),
            Text("${double.parse(temp_max).round()}°",
                style: const TextStyle(
                    fontSize: 20, color: Color.fromARGB(150, 0, 0, 0))),
          ]),
        ],
      )
    ]),
  );
}
