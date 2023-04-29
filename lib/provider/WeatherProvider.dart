import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:home_widget/home_widget.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/helper/type_code.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/models/CurrentForecast.dart';
import 'package:weather_app/network/WeatherApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/database_helper.dart';

class WeatherProvider with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool isLoading = false;

  List<dynamic> _dataForecastDetail = [];

  List<dynamic> get getDataForeCastDetail {
    return [..._dataForecastDetail];
  }

  List<CurrentForeCast> _currentWeatherLocations = [];

  List<CurrentForeCast> get getCurrentLocationsWeather {
    return [..._currentWeatherLocations];
  }

  List<String> geoCurrent = [];

  getGeoCurrent() {
    return [...geoCurrent];
  }

  Future<dynamic> dataForecastDetail(var lat, var lon,
      {bool isReboot = false}) async {
    if (isReboot) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? current = [];
      bool isExistCurrent = prefs.containsKey('current');
      if (!isExistCurrent) {
        if (lat == null && lon == null) {
          lat = '21';
          lon = '105';
        }
        await prefs.setStringList('current', <String>[lat, lon]);
      }

      current = prefs.getStringList('current');

      lat = current?[0];
      lon = current?[1];

      geoCurrent = [lat, lon];
    }

    String apiCurrentForecast =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&lang=vi&appid=${dotenv.env['API_KEY_WEATHER']}';

    String apiHourlyForecast =
        'https://pro.openweathermap.org/data/2.5/forecast/hourly?lat=$lat&lon=$lon&units=metric&lang=vi&appid=${dotenv.env['API_KEY_WEATHER']}';

    String apiDailyForeCast =
        'https://pro.openweathermap.org/data/2.5/forecast/daily?lat=$lat&lon=$lon&cnt=7&units=metric&lang=vi&appid=${dotenv.env['API_KEY_WEATHER']}';

    String apiAirPollution =
        "https://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lon&appid=${dotenv.env['API_KEY_WEATHER']}";

    try {
      List<dynamic> result = await Future.wait([
        http.get(Uri.parse(apiCurrentForecast)),
        http.get(Uri.parse(apiHourlyForecast)),
        http.get(Uri.parse(apiDailyForeCast)),
        http.get(Uri.parse(apiAirPollution))
      ]);

      _dataForecastDetail = result;

      notifyListeners();

      if (isReboot) {
        CurrentForeCast currentForeCast =
            CurrentForeCast.fromJson(jsonDecode(result[0].body));

        HomeWidget.saveWidgetData<String>('_location', currentForeCast.name);

        HomeWidget.saveWidgetData<String>(
            '_temp', "${currentForeCast.main?.temp?.round().toString()}°");

        int dt = currentForeCast.dt! + currentForeCast.timezone! - 25200;
        dynamic code = currentForeCast.weather?[0].icon;
        String type = getTypeCode(code, dt);

        HomeWidget.saveWidgetData<String>('_img', "a$type");

        HomeWidget.updateWidget(name: 'HomeScreenWidgetProvider');
      }

      return result;
    } catch (error) {
      throw error;
    }
  }

  Future<dynamic> savedLocationForecast() async {
    List<Map<String, dynamic>> data = [];

    data = await dbHelper.queryAllRows();

    int len = data.length;
    for (var i = 0; i < len; i++) {
      CurrentForeCast currentForeCast = await WeatherApiClient()
          .dataForecastCurrent(data[i]['lat'], data[i]['lon'], null);

      _currentWeatherLocations.insert(i, currentForeCast);
    }

    notifyListeners();
  }

  void updateCurrentWeatherLocation(var result, var q) async {
    CurrentForeCast currentForeCast =
        await WeatherApiClient().dataForecastCurrent(result.lat, result.lon, q);

    if (currentForeCast.coord?.lat == null) {
      return;
    }

    var lat = currentForeCast.coord?.lat;
    var lon = currentForeCast.coord?.lon;
    var city = currentForeCast.name;

    var res = await dbHelper.insert(lat, lon, city);

    if (res != 0) {
      _currentWeatherLocations = [..._currentWeatherLocations, currentForeCast];
    }

    isLoading = false;
    notifyListeners();
  }

  void updateHomeWidget(String lat, String lon) async {
    CurrentForeCast currentForeCast =
        await WeatherApiClient().dataForecastCurrent(lat, lon, null);

    HomeWidget.saveWidgetData<String>('_location', currentForeCast.name);

    HomeWidget.saveWidgetData<String>(
        '_temp', "${currentForeCast.main?.temp?.round().toString()}°");

    int dt = currentForeCast.dt! + currentForeCast.timezone! - 25200;
    dynamic code = currentForeCast.weather?[0].icon;
    String type = getTypeCode(code, dt);

    HomeWidget.saveWidgetData<String>('_img', "a$type");

    HomeWidget.updateWidget(name: 'HomeScreenWidgetProvider');
  }

  void deleteCurrentWeatherLocation(var idx) async {
    _currentWeatherLocations.removeAt(idx);
    notifyListeners();
  }

  void loading() {
    isLoading = true;
    notifyListeners();
  }

  void turnOffLoading() {
    isLoading = false;
    notifyListeners();
  }

  addGeoCurrentToSF(var lat, var lon) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('current', [lat, lon]);
    geoCurrent = [lat, lon];
    updateHomeWidget(lat, lon);
    notifyListeners();
  }

  getGeoCurrentValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('current');
  }

  changeIndexCurrentLocationsWeather(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final CurrentForeCast item = _currentWeatherLocations.removeAt(oldIndex);
    _currentWeatherLocations.insert(newIndex, item);

    // Map<String, dynamic> row = {
    //   DatabaseHelper.lat: item.coord?.lat,
    //   DatabaseHelper.lon: item.coord?.lon
    // };

    // await dbHelper.changeIndex(oldIndex, newIndex, row);
    notifyListeners();
  }
}
