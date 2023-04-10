import 'package:flutter/material.dart';
import 'package:weather_app/models/Weather.dart';
import 'package:weather_app/widget/address_search.dart';
import 'package:weather_app/widget/popular_location.dart';
import 'package:weather_app/widget/list_location.dart';
import 'package:weather_app/network/PlaceService.dart';

import 'database/database_helper.dart';
import 'main.dart';
// import 'models/Suggestion.dart';
import 'network/WeatherApiClient.dart';

List<Map<String, dynamic>> data = [];

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _PositionPageState();
}

class _PositionPageState extends State<LocationPage> {
  bool _isEdit = false;
  bool _isOpenMap = false;
  List<Weather> data_weather = [];

  openMap() {
    setState(() {
      _isOpenMap = !_isOpenMap;
    });
  }

  void _requestSqlDataAsync() async {
    data = await dbHelper.queryAllRows();

    var len = data.length;
    List<Weather> data_weather_tmp = [];

    for (var i = 0; i < len; i++) {
      var data_i = data[i];

      Weather weather = await WeatherApiClient().getWeatherLocation(data[i]);

      data_weather_tmp.insert(i, weather);

      setState(() {
        data_weather = data_weather_tmp;
      });
    }
    print("data_weather $data_weather");
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _requestSqlDataAsync();
    });
  }

  @override
  Widget build(BuildContext context) {
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
              title: Text("Sửa địa điểm "),
              elevation: 0,
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isEdit = !_isEdit;
                    });
                  },
                  child: Text(!_isEdit ? 'Chỉnh sửa' : 'Làm xong'),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                )
              ],
            )
          : null,
      body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              SearchBar(
                onSearch: (String) {},
                openMap: openMap,
                isOpenMap: _isOpenMap,
              ),
              if (!_isOpenMap)
                listLocation(isEdit: _isEdit, data: data_weather)
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

                setState(() {
                  data = [...data, row];
                });
              }
            },
          ),
        )
      ],
    );
  }
}
