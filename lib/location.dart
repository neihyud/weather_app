import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/WeatherProvider.dart';
import 'package:weather_app/widget/AddressSearch.dart';
import 'package:weather_app/widget/PopularLocation.dart';
import 'package:weather_app/widget/SavedLocation.dart';
import 'package:weather_app/network/PlaceService.dart';

import 'database/database_helper.dart';
import 'main.dart';
// import 'models/Suggestion.dart';
import 'models/CurrentForecast.dart';
import 'network/WeatherApiClient.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _PositionPageState();
}

class _PositionPageState extends State<LocationPage> {
  bool _isEdit = false;
  bool _isOpenMap = false;
  // List<Weather> data_weather = [];

  openMap() {
    setState(() {
      _isOpenMap = !_isOpenMap;
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context);
    List<CurrentForeCast> listLocationsWeather =
        weatherData.getCurrentLocationsWeather;

    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: !_isOpenMap
          ? AppBar(
              // backgroundColor: Colors.transparent,
              leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close)),
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
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Text(!_isEdit ? 'Chỉnh sửa' : 'Làm xong'),
                )
              ],
            )
          : null,
      body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SearchBar(
                onSearch: (String) {},
                openMap: openMap,
                isOpenMap: _isOpenMap,
              ),
              if (!_isOpenMap)
                SavedLocation(isEdit: _isEdit)
              // listLocation(_isEdit, data_weather)
              else
                locationPopulation(),
            ],
          )),
    );
  }
}

class SearchBar extends StatefulWidget {
  final Function() openMap;
  final Function(String) onSearch;

  final bool isOpenMap;

  const SearchBar(
      {Key? key,
      required this.onSearch,
      required this.openMap,
      required this.isOpenMap})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _searchController = TextEditingController();

  // final bool isOpenMap;
  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context);
    List<CurrentForeCast> listLocationsWeather =
        weatherData.getCurrentLocationsWeather;
    return Row(
      children: [
        if (widget.isOpenMap)
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(0.0),
            constraints: const BoxConstraints(),
            onPressed: () {
              // Navigator.pop(context);
              widget.openMap();
            },
          ),
        Expanded(
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search...',
              filled: true, //<-- SEE HERE
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 18.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
              suffixIcon: IconButton(
                icon: const Icon(Icons.map),
                onPressed: () {
                  // widget.isOpenMap = !isOpenMap;
                  widget.onSearch(_searchController.text);
                  widget.openMap();
                },
              ),
            ),
            onTap: () async {
              final Suggestion? result = await showSearch(
                context: context,
                delegate: AddressSearch(),
              );
              if (result != null) {
                Map<String, dynamic> row = {
                  DatabaseHelper.columnLat: result.lat,
                  DatabaseHelper.columnLng: result.lon
                };

                final id = await dbHelper.insert(row);

                CurrentForeCast currentForeCast = await WeatherApiClient()
                    .dataForecastCurrent(
                        row['columnLat'], row['columnLng'], null);

                print("currentForeCast ${currentForeCast.toJson()}");
                weatherData.updateCurrentLocationsWeather(result);

                setState(() {
                  print("run listLocation");
                  listLocationsWeather = [
                    ...listLocationsWeather,
                    currentForeCast
                  ];

                  print(
                      "LENGTH CURRENT WEATHER ${weatherData.getCurrentLocationsWeather.length}");
                });
              }
            },
          ),
        )
      ],
    );
  }
}
