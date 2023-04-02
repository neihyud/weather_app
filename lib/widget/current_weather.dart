import 'package:flutter/material.dart';

Widget currentWeather(String temp_current, String temp_min, String temp_max) {
  print("object");
  return Container(
    height: 125,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Color.fromARGB(50, 56, 66, 82),
    ),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Mua"),
          Text(
            "56 C",
            style: TextStyle(fontSize: 60, fontWeight: FontWeight.w800),
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Nhiệt độ"),
              SizedBox(width: 8),
              Text("${temp_current}"),
              SizedBox(width: 8),
              Icon(Icons.arrow_drop_down),
              Text("${temp_min}"),
              SizedBox(width: 8),
              Icon(Icons.arrow_drop_up),
              Text("${temp_max}"),
            ],
          )
        ]),
  );
}
