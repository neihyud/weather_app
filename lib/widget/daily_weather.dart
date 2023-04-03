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
      color: Color.fromARGB(50, 56, 66, 82),
    ),
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 7,
        itemBuilder: (BuildContext context, index) {
          String? dateTime = weather.daily?.time?[index];
          DateTime datetime = DateTime.parse(dateTime!);

          String weekday = "${datetime.weekday}";

          String current_weekday = "";

          switch (weekday) {
            case "1":
              current_weekday = 'Monday';
              break;
            case "2":
              current_weekday = 'Tuesday';
              break;
            case "3":
              current_weekday = 'Wednesday';
              break;
            case "4":
              current_weekday = 'Thursday';
              break;
            case "5":
              current_weekday = 'Friday';
              break;
            case "6":
              current_weekday = 'Saturday';
              break;
            case "7":
              current_weekday = 'Sunday';
              break;

            default:
              current_weekday = 'Err';
          }
          if (index == 0) {
            current_weekday = "Today";
          }

          return day(
            "${current_weekday}",
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
        child: Text("${weekday}",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
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
            Text("  /  ", style: TextStyle(fontSize: 20)),
            Text("${double.parse(temp_max).round()}°",
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(150, 0, 0, 0))),
          ]),
        ],
      )
    ]),
  );
}
