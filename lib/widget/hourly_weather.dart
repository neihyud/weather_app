import 'package:flutter/material.dart';
import 'package:weather_app/helper/icon_weather.dart';

import '../models/HourlyForecast.dart';

Widget hourlyWeather(List<HourlyForeCast> hourlyForeCast) {
  return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(50, 56, 66, 82),
      ),
      child: ListView.builder(
          itemCount: 24,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, index) {
            String? timeString = hourlyForeCast[index].dtTxt;

            DateTime dateTime = DateTime.parse(timeString!);

            String hourString = "${dateTime.hour}".padLeft(2, '0');
            String minuteString = "${dateTime.minute}".padLeft(2, '0');

            String currentTime = "$hourString:$minuteString";

            var temp = hourlyForeCast[index].main?.temp;
            var iconCode = hourlyForeCast[index].weather?[0].icon;

            return box(Colors.transparent, currentTime, temp, iconCode);
          }));
}

Widget box(Color backgroundColor, String time, var tmp, var iconCode) {
  return Container(
      margin: const EdgeInsets.all(10),
      color: backgroundColor,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(time, style: const TextStyle(color: Colors.white, fontSize: 18)),
          getIcon(iconCode, size: 45),
          Text('$tmp°',
              style: const TextStyle(color: Colors.white, fontSize: 18))
        ],
      ));
}
