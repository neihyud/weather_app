import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/models/CurrentForecast.dart';

import '../helper/background_widget_code.dart';
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
  late List<String> geoCurrent;

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context);
    var listLocationsWeather = weatherData.getCurrentLocationsWeather;

    geoCurrent = weatherData.getGeoCurrent();

    Widget location(
        int index, CurrentForeCast currentForeCast, WeatherProvider weatherData,
        {bool isHome = false}) {
      var lat = currentForeCast.coord?.lat.toString();
      var lon = currentForeCast.coord?.lon.toString();

      var temp = currentForeCast.main?.temp;

      var iconCode = currentForeCast.weather?[0].icon;

      var name = currentForeCast.name;

      bool isHome = false;

      if (geoCurrent[0] == lat && geoCurrent[1] == lon) {
        isHome = true;
      }

      return GestureDetector(
        key: Key('$index'),
        onTap: () =>
            {weatherData.dataForecastDetail(lat, lon), Navigator.pop(context)},
        child: Row(children: [
          if (widget.isEdit && !isHome)
            InkWell(
              onDoubleTap: () {
                // updateGeo(lat, lon);
                weatherData.addGeoCurrentToSF(lat, lon);
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromARGB(255, 160, 178, 207)),
                padding: const EdgeInsets.all(3),
                child: const Icon(
                  Icons.home,
                  color: Colors.white,
                ),
              ),
            ),
          Flexible(
            child: Stack(children: [
              Container(
                margin: widget.isEdit && !isHome
                    ? const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
                    : const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 12.0),
                decoration: BoxDecoration(
                    color: getBackgroundWColor('$iconCode'),
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
                      const SizedBox(width: 15),
                      Flexible(
                        flex: 1,
                        child: Wrap(children: [
                          Text(
                            "$name",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          const SizedBox(width: 5),
                          if (isHome)
                            const Icon(
                              Icons.location_on,
                              size: 24,
                              color: Colors.white,
                            ),
                        ]),
                      ),
                    ]),
              ),
              if (widget.isEdit && !isHome)
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
                      color: Colors.red,
                    ),
                  ),
                ),
            ]),
          ),
          if (widget.isEdit && !isHome)
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
                location(
                  index,
                  listLocationsWeather[index],
                  weatherData,
                )
            ]),
      ),
    );
  }
}
