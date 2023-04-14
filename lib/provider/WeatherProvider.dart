import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/main.dart';
import 'package:weather_app/models/CurrentForecast.dart';
import 'package:weather_app/network/WeatherApiClient.dart';

class WeatherProvider with ChangeNotifier {
  List<dynamic> _dataForecastDetail = [];

  List<dynamic> get getDataForeCastDetail {
    return [..._dataForecastDetail];
  }

  List<CurrentForeCast> _currentWeatherLocations = [];

  List<CurrentForeCast> get getCurrentLocationsWeather {
    return [..._currentWeatherLocations];
  }

  Future<dynamic> dataForecastDetail(var lat, var lon) async {
    if (lat == null || lon == null) {
      lat = '21';
      lon = '105';
    }

    String apiCurrentForecast =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=${dotenv.env['API_KEY_WEATHER']}';

    String apiHourlyForecast =
        'https://pro.openweathermap.org/data/2.5/forecast/hourly?lat=$lat&lon=$lon&units=metric&appid=${dotenv.env['API_KEY_WEATHER']}';

    String apiDailyForeCast =
        'https://pro.openweathermap.org/data/2.5/forecast/daily?lat=$lat&lon=$lon&cnt=7&units=metric&appid=${dotenv.env['API_KEY_WEATHER']}';

    String apiAirPollution =
        "https://api.openweathermap.org/data/2.5/air_pollution?lat=21&lon=105&appid=${dotenv.env['API_KEY_WEATHER']}";

    try {
      List<dynamic> result = await Future.wait([
        http.get(Uri.parse(apiCurrentForecast)),
        http.get(Uri.parse(apiHourlyForecast)),
        http.get(Uri.parse(apiDailyForeCast)),
        http.get(Uri.parse(apiAirPollution))
      ]);

      _dataForecastDetail = result;
      notifyListeners();

      return result;
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<dynamic> savedLocationForecast() async {
    List<Map<String, dynamic>> data = [];

    data = await dbHelper.queryAllRows();

    int len = data.length;
    for (var i = 0; i < len; i++) {
      CurrentForeCast currentForeCast = await WeatherApiClient()
          .dataForecastCurrent(data[i]['lat'], data[i]['lng'], null);

      _currentWeatherLocations.insert(i, currentForeCast);
    }

    notifyListeners();
  }

  void updateCurrentWeatherLocation(var result) async {
    CurrentForeCast currentForeCast = await WeatherApiClient()
        .dataForecastCurrent(result.lat, result.lon, null);

    _currentWeatherLocations = [..._currentWeatherLocations, currentForeCast];

    notifyListeners();
  }

  void deleteCurrentWeatherLocation(var idx) async {
    _currentWeatherLocations.removeAt(idx);
    notifyListeners();
  }
}
