import 'dart:ffi';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import '../models/DailyForecast.dart';
import '../helper/icon_weather.dart';

String getDayOfWeek(final day) {
  DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
  final dayOfWeek = DateFormat('EEEE').format(time);
  return dayOfWeek;
}

Widget dailyWeather(List<DailyForeCast> dailyForeCast) {
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
          var dt = dailyForeCast[index].dt;
          String currentWeekDay = getDayOfWeek(dt);
          var iconCode = dailyForeCast[index].weather?[0].icon;
          var tempMin = dailyForeCast[index].temp?.min?.round();
          var tempMax = dailyForeCast[index].temp?.max?.round();
          return day(
            currentWeekDay,
            iconCode,
            tempMin,
            tempMax,
          );
        }),
  );
}

Widget day(String weekday, var iconCode, var tempMin, var tempMax) {
  return SizedBox(
    height: 65,
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      SizedBox(
        width: 100,
        child: Text(weekday,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
      ),
      getIcon(iconCode),
      Wrap(
        spacing: 12.0,
        children: [
          Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
            Text(
              "${double.parse(tempMin).round()}°",
              style: const TextStyle(fontSize: 20),
            ),
            const Text("  /  ", style: TextStyle(fontSize: 20)),
            Text("${double.parse(tempMax).round()}°",
                style: const TextStyle(
                    fontSize: 20, color: Color.fromARGB(150, 0, 0, 0))),
          ]),
        ],
      )
    ]),
  );
}
