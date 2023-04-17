import 'package:flutter/material.dart';
import 'package:weather_app/models/CurrentForecast.dart';
import 'package:weather_app/helper/description_code.dart';

Widget  currentWeather(CurrentForeCast currentForeCast) {
  var windSpeed = currentForeCast.wind?.speed;

  var humidity = currentForeCast.main?.humidity;

  var cloudiness = currentForeCast.clouds?.all;

  var des = currentForeCast.weather?[0].main;

  var temp = currentForeCast.main?.temp?.round();

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
          Text("${currentForeCast.name}"),
          Text(
            "${temp.toString()} °C",
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
                  Text("$windSpeed km/h"),
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
                  Text("$humidity %"),
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
                  Text("$cloudiness %"),
                ],
              ),
            ],
          )
        ]),
  );
}
