import 'package:flutter/material.dart';
import 'package:weather_app/models/Weather.dart';
import 'package:weather_app/widget/description_code.dart';

Widget currentWeather(Weather weather) {
  var windspeed = weather.currentWeather?.windspeed;

  int idx_hour = DateTime.now().hour;
  var humidity = weather.hourly?.humidity?[idx_hour];

  var cloudcover = weather.hourly?.cloudcover?[idx_hour];

  return Container(
    height: 180,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Color.fromARGB(50, 56, 66, 82),
    ),
    padding: const EdgeInsets.all(10),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getDesCode((weather.currentWeather?.weathercode).toString()),
          Text(
            "${weather.currentWeather?.temperature?.round()} °C",
            style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w800),
          ),
          Row(
            children: [
              Wrap(
                spacing: 6,
                children: [
                  Image.asset(
                    "assets/img/windspeed.png",
                    width: 18,
                  ),
                  Text("${windspeed} km/h"),
                ],
              ),
              const SizedBox(width: 24),
              Wrap(
                spacing: 6,
                children: [
                  Image.asset(
                    "assets/img/humidity.png",
                    width: 18,
                  ),
                  Text("${humidity} %"),
                ],
              ),
              const SizedBox(width: 24),
              Wrap(
                spacing: 6,
                children: [
                  Image.asset(
                    "assets/img/clouds.png",
                    width: 18,
                  ),
                  Text("${cloudcover} %"),
                ],
              ),
            ],
          )
        ]),
  );
}
