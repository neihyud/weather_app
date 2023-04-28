import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import '../helper/icon_weather_code.dart';
import '../models/DailyForecast.dart';

String getDayOfWeek(final day) {
  DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
  final dayOfWeek = DateFormat('EEEE').format(time);
  return dayOfWeek;
}

Widget dailyWeather(List<DailyForeCast> dailyForeCast) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: const Color.fromARGB(35, 255, 255, 255),
    ),
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
    child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 7,
        itemBuilder: (BuildContext context, index) {
          int dt = dailyForeCast[index].dt!;

          String currentWeekDay = getDayOfWeek(dt);

          if (index == 0) currentWeekDay = "Today";

          var iconCode = dailyForeCast[index].weather?[0].icon;
          var tempMin = dailyForeCast[index].temp?.min?.round();
          var tempMax = dailyForeCast[index].temp?.max?.round();

          return day(currentWeekDay, iconCode, tempMin, tempMax, dt);
        }),
  );
}

Widget day(String weekday, var iconCode, var tempMin, var tempMax, var dt) {
  return SizedBox(
    height: 65,
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      SizedBox(
        width: 100,
        child: Text(weekday,
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.white)),
      ),
      getIconWeather(iconCode, dt),
      SizedBox(
        width: 80,
        child: Center(
          child: Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
            Text(
              "${tempMin.toString()}°",
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            const Text(" / ",
                style: TextStyle(fontSize: 20, color: Colors.white)),
            Text("${tempMax.toString()}°",
                style: const TextStyle(fontSize: 20, color: Colors.white70)),
          ]),
        ),
      )
    ]),
  );
}
