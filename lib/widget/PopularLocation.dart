import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/main.dart';

import '../database/database_helper.dart';
import '../provider/WeatherProvider.dart';

@override
Widget locationPopulation(BuildContext context) {
  final weatherData = Provider.of<WeatherProvider>(context);
  Position _currentPosition;
  List<String> location = [
    "Hanoi",
    "Nepal",
    "India",
    "China",
    "USA",
    "Canada",
    "Brazil",
  ];
  return Expanded(
    // flex: 1,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: 20),
        Row(
          children: const [
            Text("CÁC VỊ TRÍ PHỔ BIẾN",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            Icon(Icons.local_fire_department)
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Flexible(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black12,
                    width: 1.0,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10)),
            child: GridView.count(
                childAspectRatio: (1 / .3),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                // primary: false,
                // padding: const EdgeInsets.all(20),
                // crossAxisSpacing: 10,
                mainAxisSpacing: 0,
                crossAxisCount: 2,
                children: location.map((e) {
                  return day();
                }).toList()),
          ),
        )
      ],
    ),
  );
}

Widget day() {
  return const ListTile(
    title: Text("Hanoi"),
    subtitle: Text("Hanoi/VietName"),
  );
}
