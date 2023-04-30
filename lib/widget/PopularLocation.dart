import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../models/Geometry.dart';
import '../provider/WeatherProvider.dart';
import 'Search.dart';

@override
Widget popularLocation(BuildContext context) {
  final weatherData = Provider.of<WeatherProvider>(context);
  Position _currentPosition;
  var _location = [
    "Amsterdam",
    "Athena",
    "Bagdad",
    "Bangkok",
    "Bengaluru",
    "Beograd",
    "Berlin",
    "Bogotá",
    "Bắc Kinh",
    "Cairo",
    "Cape Town",
    "Delhi",
    "Honolulu",
    "Hà Nội",
    "Hồng Kông",
    "Jakarta",
    "La Habana",
    "Luân Đôn",
    "Moskva",
    "Paris",
    "Seoul",
    "Tokyo"
  ];

  var _city = [
    "Noord-Holland/Hà Lan",
    "Attica/Hy Lạp",
    "Bagdad/Iraq",
    "Bangkok/Thái Lan",
    "Karnataka/Ấn Độ",
    "Beograd/Serbia",
    "Berlin/Đức",
    "Bogotá/Colombia",
    "Bắc Kinh/Trung Quốc",
    "Cairo/Ai Cập",
    "Tây Cape/Nam Phi",
    "Delhi/Ấn Độ",
    "Hawaii/Hoa Kỳ",
    "Hà Nội/Việt Nam",
    "Sa Điền/Hồng Kông",
    "Jakarta/Indonesia",
    "La Habana/Cuba",
    "Luân Đôn/Anh",
    "Moskva/Nga",
    "Paris/Pháp",
    "Seoul/Hàn Quốc",
    "Tokyo/Nhật Bản"
  ];

  var _geo_lat = [
    52.5833,
    40.2942,
    33.3406,
    13.75,
    13.5,
    44.804,
    52.5244,
    4.6097,
    39.9075,
    30.0626,
    -33.9258,
    28.6667,
    20.7503,
    21.0245,
    22.2855,
    -6.2146,
    23.133,
    51.5085,
    55.7522,
    48.8534,
    37.5683,
    35.6895
  ];
  var _geo_lon = [
    4.9167,
    -87.2489,
    44.4009,
    100.5167,
    76,
    20.4651,
    13.4105,
    -74.0817,
    116.3972,
    31.2497,
    18.4232,
    77.2167,
    -156.5003,
    105.8412,
    114.1577,
    106.8451,
    -82.383,
    -0.1257,
    37.6156,
    2.3488,
    126.9778,
    139.6917
  ];

  Widget location(var lat, var lon, var place, var city) {
    return ListTile(
      title: Text(
        "$place",
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        "$city",
        style: const TextStyle(color: Colors.white70),
      ),
      onTap: () {
        weatherData.updateCurrentWeatherOfLocation(Geo(lat, lon));
        Navigator.pop(context);
      },
    );
  }

  return Column(
    mainAxisSize: MainAxisSize.max,
    children: [
      const SizedBox(height: 10),
      Row(
        children: const [
          Text("CÁC VỊ TRÍ PHỔ BIẾN",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.white)),
          SizedBox(
            width: 5,
          ),
          Icon(
            Icons.local_fire_department,
            color: Colors.white,
          )
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Flexible(
        fit: FlexFit.tight,
        child: Container(
          padding: const EdgeInsets.only(bottom: 15, left: 5),
          decoration: BoxDecoration(
              color: const Color.fromARGB(30, 233, 249, 253),
              borderRadius: BorderRadius.circular(15)),
          child: GridView.count(
              childAspectRatio: (1 / .3),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: _location.asMap().entries.map((entry) {
                int index = entry.key;
                var lat = _geo_lat[index];
                var lon = _geo_lon[index];

                var place = _location[index];
                var city = _city[index];

                return location(lat, lon, place, city);
              }).toList()),
        ),
      )
    ],
  );
}
