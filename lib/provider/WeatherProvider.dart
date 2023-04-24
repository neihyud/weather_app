import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:home_widget/home_widget.dart';
import 'package:http/http.dart' as http;
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

  Future<dynamic> dataForecastDetail(var lat, var lon) async {
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

      CurrentForeCast currentForeCast =
          CurrentForeCast.fromJson(jsonDecode(result[0].body));

      await HomeWidget.saveWidgetData<String>(
          '_location', currentForeCast.name);
      await HomeWidget.saveWidgetData<String>(
          '_temp', currentForeCast.main?.temp?.round().toString());
      await HomeWidget.updateWidget(
          name: 'HomeScreenWidgetProvider',
          iOSName: 'HomeScreenWidgetProvider');

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

  void updateCurrentWeatherLocation(var result, var q) async {
    CurrentForeCast currentForeCast =
        await WeatherApiClient().dataForecastCurrent(result.lat, result.lon, q);

    if (currentForeCast.coord?.lat == null) {
      return;
    }

    _currentWeatherLocations = [..._currentWeatherLocations, currentForeCast];

    isLoading = false;
    notifyListeners();
  }

  void deleteCurrentWeatherLocation(var idx) async {
    _currentWeatherLocations.removeAt(idx);
    notifyListeners();
  }

  void loading() {
    isLoading = true;
    notifyListeners();
  }

  addListStringToSF(var lat, var lon) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('current', [lat, lon]);
  }

  getListStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('current');
  }

  getGeoLastCurrentLocation() {
    int len = _currentWeatherLocations.length;
    return _currentWeatherLocations[len - 1];
  }

  changeIndexCurrentLocationsWeather(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final CurrentForeCast item = _currentWeatherLocations.removeAt(oldIndex);
    _currentWeatherLocations.insert(newIndex, item);

    Map<String, dynamic> row = {
      DatabaseHelper.columnLat: item.coord?.lat,
      DatabaseHelper.columnLng: item.coord?.lon
    };

    // await dbHelper.changeIndex(oldIndex, newIndex, row);
    notifyListeners();
  }
}
