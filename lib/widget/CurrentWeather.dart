import 'package:flutter/material.dart';
import 'package:weather_app/helper/des_weather_code.dart';

Widget currentWeather(code, temp) {
  return Container(
    height: 250,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
    ),
    padding: const EdgeInsets.all(10),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 23),
                child: Text(
                  temp.toString(),
                  style: const TextStyle(
                      fontSize: 100,
                      height: 0.98,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
              const Text('°C',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          getDesCode('$code')
        ]),
  );
}
