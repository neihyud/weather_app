import 'dart:ffi';

import 'package:flutter/material.dart';

import '../models/Weather.dart';

// List<String> days, List<Int> weatherCode,
// List<double> temp_min, List<double> temp_max,

Widget dailyWeather(Weather weather) {
  return SizedBox(
    width: 400,
    height: 250,
    child: ListView.builder(
        itemCount: 7,
        itemBuilder: (BuildContext context, index) {
          return day(
            "${weather.daily?.time?[index]}",
            "${weather.daily?.weathercode?[index]}",
            "${weather.daily?.temperature2MMin?[index]}",
            "${weather.daily?.temperature2MMax?[index]}",
          );
        }
        ),
  );
}

Widget day(String time, String code, String temp_min, String temp_max) {
  return SizedBox(
    height: 65,
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text("${time}"),
      Icon(Icons.cloud),
      Wrap(
        spacing: 12.0,
        children: [
          Text("${temp_min}"),
          Text("${temp_max}"),
        ],
      )
    ]),
  );
}
