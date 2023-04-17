import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/WeatherProvider.dart';
import 'package:weather_app/widget/AddressSearch.dart';
import 'package:weather_app/widget/SavedLocation.dart';
import 'package:weather_app/network/PlaceService.dart';

import 'database/database_helper.dart';
import 'main.dart';
import 'models/CurrentForecast.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _PositionPageState();
}

class _PositionPageState extends State<LocationPage> {
  bool _isEdit = false;
  bool _isLoading = false;

  loading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context);

    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.close)),
        title: const Text("Sửa địa điểm "),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _isEdit = !_isEdit;
              });
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: Text(!_isEdit ? 'Chỉnh sửa' : 'Làm xong'),
          )
        ],
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SearchBar(),
              if (weatherData.isLoading)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              SavedLocation(isEdit: _isEdit, isLoading: _isLoading)
            ],
          )),
    );
  }
}

// =============Search Bar ====================
class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context);

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            readOnly: true,
            decoration: InputDecoration(
              hintText: 'Search...',
              filled: true,
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 18.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
              suffixIcon: IconButton(
                icon: const Icon(Icons.gps_fixed),
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

                final id = await dbHelper.insert(row);

                weatherData.updateCurrentWeatherLocation(result, null);
              }
            },
          ),
        )
      ],
    );
  }
}

// ======================== GPS =================================

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
