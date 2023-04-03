import 'package:flutter/material.dart';
import 'package:weather_app/models/Weather.dart';
import 'package:weather_app/widget/icon_weather.dart';

Widget hourlyWeather(Weather weather) {
  int idx_hour = DateTime.now().hour;
  print("current_time ${idx_hour}");

  var len = weather.hourly?.time?.length;

  if (len != null) {
    len = len - idx_hour;
  }

  return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(50, 56, 66, 82),
      ),
      child: ListView.builder(
          itemCount: len,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, index) {
            String? datetimeString = weather.hourly?.time?[index + idx_hour];
            DateTime datetime = DateTime.parse(datetimeString!);

            String hourString = "${datetime.hour}".padLeft(2, '0');
            String minuteString = "${datetime.minute}".padLeft(2, '0');

            String current_time = "${hourString}:${minuteString}";
            // print("hour ${hour}");
            return box(
                Colors.transparent,
                "${current_time}",
                "${weather.hourly?.temperature2M?[index + idx_hour]}",
                "${weather.hourly?.weathercode?[index + idx_hour]}");
          }));
}

Widget box(Color backgroundcolor, String time, String tmp, String weathercode) {
  return Container(
      margin: EdgeInsets.all(10),
      color: backgroundcolor,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(time, style: TextStyle(color: Colors.white, fontSize: 18)),
          // Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
          // Icon(
          //   Icons.cloudy_snowing,
          //   size: 45,
          // )
          getIcon(weathercode, size: 45),
          // Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
          Text('${double.parse(tmp).round()}°',
              style: TextStyle(color: Colors.white, fontSize: 18))
        ],
      ));
}
