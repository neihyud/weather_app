import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/models/CurrentForecast.dart';

import '../provider/WeatherProvider.dart';

class SavedLocation extends StatefulWidget {
  final bool isEdit;
  final bool isLoading;
  const SavedLocation(
      {super.key, required this.isEdit, required this.isLoading});

  @override
  State<SavedLocation> createState() => _SavedLocationState();
}

class _SavedLocationState extends State<SavedLocation> {
  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context);
    var listLocationsWeather = weatherData.getCurrentLocationsWeather;

    return Theme(
      data: ThemeData(canvasColor: Colors.transparent),
      child: Expanded(
        child: ReorderableListView(
            onReorder: (int oldIndex, int newIndex) {
              weatherData.changeIndexCurrentLocationsWeather(
                  oldIndex, newIndex);
            },
            children: [
              for (int index = 0;
                  index < listLocationsWeather.length;
                  index += 1)
                location(index, listLocationsWeather[index], weatherData)
            ]),
      ),
    );
  }

  Widget location(
      int index, CurrentForeCast currentForeCast, WeatherProvider weatherData) {
    var temp = currentForeCast.main?.temp;

    var iconCode = currentForeCast.weather?[0].icon;
    var desCode = currentForeCast.weather?[0].description;

    var name = currentForeCast.name;
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(currentForeCast.dt! * 1000);

    var day = "${dateTime.day}".padLeft(2, '0');
    var month = "${dateTime.month}".padLeft(2, '0');

    var hour = "${dateTime.hour}".padLeft(2, '0');
    var minute = "${dateTime.minute}".padLeft(2, '0');

    var lat = currentForeCast.coord?.lat.toString();
    var lon = currentForeCast.coord?.lon.toString();

    return GestureDetector(
      key: Key('$index'),
      onTap: () async => {
        weatherData.dataForecastDetail(lat, lon),
        weatherData.addListStringToSF(lat, lon),
        Navigator.pop(context)
      },
      child: Row(children: [
        if (widget.isEdit)
          const Icon(
            Icons.home,
            color: Colors.white,
          ),
        Flexible(
          child: Stack(children: [
            Container(
              margin: widget.isEdit
                  ? const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
                  : const EdgeInsets.symmetric(vertical: 8),
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
              decoration: BoxDecoration(
                  // image: const DecorationImage(
                  //   image: AssetImage("assets/img/sun_widget.png"),
                  //   fit: BoxFit.cover,
                  // ),
                  borderRadius: BorderRadius.circular(15)),
              height: 100,
              child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${temp?.round().toString()}°",
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 50,
                          color: Colors.white),
                    ),
                    const Divider(
                      height: 20,
                      thickness: 5,
                      indent: 20,
                      endIndent: 0,
                      color: Colors.white,
                    ),
                    Flexible(
                      flex: 1,
                      child: Text(
                        "$name",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ]),
            ),
            if (widget.isEdit)
              Positioned(
                top: 6,
                right: 16,
                child: GestureDetector(
                  onTap: () {
                    dbHelper.delete(index);
                    weatherData.deleteCurrentWeatherLocation(index);
                  },
                  child: const Icon(
                    Icons.remove_circle,
                    size: 24,
                    color: Color.fromARGB(255, 247, 73, 60),
                  ),
                ),
              ),
          ]),
        ),
        if (widget.isEdit)
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color.fromARGB(255, 160, 178, 207)),
            padding: const EdgeInsets.all(3),
            child: ReorderableDragStartListener(
              index: index,
              child: const Icon(Icons.drag_handle),
            ),
          ),
      ]),
    );
  }
}
