import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget paramsWeather(dynamic windSpeed, dynamic humidity, dynamic cloudiness) {
  windSpeed = windSpeed.round();
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Column(children: [
        Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            color: Color.fromARGB(50, 56, 66, 82),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: SvgPicture.asset(
            'assets/icons/wind.svg',
            alignment: Alignment.center,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: 60,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: const BoxDecoration(
            color: Color.fromARGB(50, 56, 66, 82),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Text(
            '$windSpeed km/h',
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
      ]),
      Column(children: [
        Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            color: Color.fromARGB(50, 56, 66, 82),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: SvgPicture.asset(
            'assets/icons/cloud.svg',
            alignment: Alignment.center,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: 60,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: const BoxDecoration(
            color: Color.fromARGB(50, 56, 66, 82),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Text(
            '$cloudiness %',
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
      ]),
      Column(children: [
        Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            color: Color.fromARGB(50, 56, 66, 82),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: SvgPicture.asset(
            'assets/icons/humidity.svg',
            alignment: Alignment.center,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: 60,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: const BoxDecoration(
            color: Color.fromARGB(50, 56, 66, 82),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Text(
            '$humidity %',
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
      ]),
    ],
  );
}
