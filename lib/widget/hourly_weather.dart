import 'package:flutter/material.dart';
import 'package:weather_app/models/Weather.dart';

Widget hourlyWeather(Weather weather) {
  List<String> countries = [
    "13:00",
    "14:00",
    "15:00",
    "16:00",
    "17:00",
    "18:00",
    "19:00",
    "20:00",
    "21:00",
  ];
  return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(50, 56, 66, 82),
      ),
      child: ListView.builder(
          // itemCount: 7,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, index) {
            return box(
              countries[index % 7],
              Colors.transparent,
              "${weather.hourly?.time?[index]}",
              "${weather.hourly?.temperature2M?[index]}",
            );
          }));
}

Widget box(String title, Color backgroundcolor, String time, String tmp) {
  return Container(
      margin: EdgeInsets.all(10),
      color: backgroundcolor,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.white, fontSize: 18)),
          // Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
          Icon(
            Icons.cloudy_snowing,
            size: 45,
          ),
          // Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
          Text('${tmp}°C', style: TextStyle(color: Colors.white, fontSize: 18))
        ],
      ));
}
