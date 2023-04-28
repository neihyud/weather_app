import 'package:flutter/material.dart';

import '../helper/icon_weather_code.dart';
import '../models/HourlyForecast.dart';

Widget hourlyWeather(List<HourlyForeCast> hourlyForeCast, dynamic timezone) {
  var gtm = timezone / 3600;

  return Container(
      height: 150,
      child: ListView.builder(
          itemCount: 24,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, index) {
            String? timeString = hourlyForeCast[index].dtTxt;

            int? dt = (hourlyForeCast[index].dt! + timezone - 25200) as int?;

            DateTime dateTime = DateTime.parse(timeString!);

            String hourString =
                "${((dateTime.hour + gtm).ceil()) % 24}".padLeft(2, '0');

            String minuteString = "${dateTime.minute}".padLeft(2, '0');

            String currentTime = "$hourString:$minuteString";

            var temp = hourlyForeCast[index].main?.temp;
            var iconCode = hourlyForeCast[index].weather?[0].icon;

            return box(currentTime, temp, iconCode, dt!);
          }));
}

Widget box(String time, var tmp, var iconCode, int dt) {
  return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(35, 255, 255, 255),
      ),
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(time, style: const TextStyle(color: Colors.white, fontSize: 18)),
          getIconWeather(iconCode, dt, size: 45),
          Text('${tmp.round().toString()}°',
              style: const TextStyle(color: Colors.white, fontSize: 18))
        ],
      ));
}
