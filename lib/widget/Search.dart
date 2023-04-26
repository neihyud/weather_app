import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../database/database_helper.dart';
import '../main.dart';
import '../provider/WeatherProvider.dart';
import 'AddressSearch.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context);

    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(40, 255, 255, 255),
                borderRadius: BorderRadius.circular(100)),
            child: TextField(
              readOnly: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: 'Search...',
                hintStyle: const TextStyle(color: Colors.white),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 18.0),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.gps_fixed),
                  color: Colors.white,
                  onPressed: () async {
                    weatherData.loading();
                    _getCurrentPosition(context, weatherData);
                  },
                ),
              ),
              onTap: () async {
                final dynamic result = await showSearch(
                  context: context,
                  delegate: AddressSearch(),
                );
                if (result != null) {
                  Map<String, dynamic> row = {
                    DatabaseHelper.columnLat: result.lat,
                    DatabaseHelper.columnLng: result.lon
                  };

                  dbHelper.insert(row);

                  weatherData.updateCurrentWeatherLocation(result, null);
                }
              },
            ),
          ),
        )
      ],
    );
  }
}

Future<bool> _handleLocationPermission(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // ignore: use_build_context_synchronously
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
    Map<String, dynamic> row = {
      DatabaseHelper.columnLat: position.latitude,
      DatabaseHelper.columnLng: position.longitude
    };

    await dbHelper.insert(row);
    weatherData.updateCurrentWeatherLocation(
        Geo(position.latitude, position.longitude), null);

    // Navigator.pop(context);
  }).catchError((e) {
    debugPrint(e);
  });
}

class Geo {
  var lat;
  var lon;

  Geo(this.lat, this.lon);
}
