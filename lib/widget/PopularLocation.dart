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
    flex: 1,
    child: Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: const [
            Text(
              "VỊ TRÍ XUNG QUANH",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                // color: Colors.white
              ),
            ),
            Icon(
              Icons.location_pin,
            )
          ],
        ),
        const SizedBox(height: 10),
        Container(
            // width: MediaQuery.of(context).size.width,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                // color: Color.fromARGB(255, 201, 149, 82),
                border: Border.all(
                    color: Colors.black12,
                    width: 1.0,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(100)),
            padding: EdgeInsets.symmetric(vertical: 0.0),
            child: InkWell(
              onTap: () {
                _getCurrentPosition(context, weatherData);
              },
              child: Row(
                children: [
                  IconButton(
                    icon: new Icon(Icons.location_pin),
                    alignment: Alignment.center,
                    padding: new EdgeInsets.all(0.0),
                    onPressed: () {},
                  ),
                  const Text("Cho phép Quyền vị trí",
                      style: TextStyle(fontWeight: FontWeight.w600))
                ],
              ),
            )),
        const SizedBox(height: 10),
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

Future<bool> _handleLocationPermission(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Location services are disabled. Please enable the services')));
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')));
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Location permissions are permanently denied, we cannot request permissions.')));
    return false;
  }
  return true;
}

Future<void> _getCurrentPosition(
    BuildContext context, WeatherProvider weatherData) async {
  final hasPermission = await _handleLocationPermission(context);

  if (!hasPermission) return;
  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
      .then((Position position) async {
    print("POSITION ${position}");

    Map<String, dynamic> row = {
      DatabaseHelper.columnLat: position.latitude,
      DatabaseHelper.columnLng: position.longitude
    };
    await dbHelper.insert(row);
    weatherData.updateCurrentWeatherLocation(
        Geo(position.latitude, position.longitude));
    Navigator.pop(context);
  }).catchError((e) {
    debugPrint(e);
  });
}

class Geo {
  var lat;
  var lon;

  Geo(this.lat, this.lon);
}
