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

import '../models/AirPollution.dart';

class WeatherProvider with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool isLoading = false;

  final List<dynamic> _detailDataOfAllPageWeather = [];
  List<dynamic> get getDetailDataOfAllPageWeather {
    return [..._detailDataOfAllPageWeather];
  }

  final List<CurrentForeCast> _currentWeatherOfLocations = [];
  List<CurrentForeCast> get getCurrentWeatherOfLocations {
    return [..._currentWeatherOfLocations];
  }

  List<String> geoCurrent = [];

  getGeoCurrent() {
    return [...geoCurrent];
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

// ====================================================

  void updateHomeWidget(String lat, String lon) async {
    CurrentForeCast currentForeCast =
        await WeatherApiClient().getDataCurrentWeather(lat, lon);

    HomeWidget.saveWidgetData<String>('_location', currentForeCast.name);

    HomeWidget.saveWidgetData<String>(
        '_temp', "${currentForeCast.main?.temp?.round().toString()}°");

    int dt = currentForeCast.dt! + currentForeCast.timezone! - 25200;
    dynamic code = currentForeCast.weather?[0].icon;
    String type = getTypeCode(code, dt);

    HomeWidget.saveWidgetData<String>('_img', "a$type");

    HomeWidget.updateWidget(name: 'HomeScreenWidgetProvider');
  }

  changeIndexCurrentLocationsWeather(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final CurrentForeCast item = _currentWeatherOfLocations.removeAt(oldIndex);
    _currentWeatherOfLocations.insert(newIndex, item);

    final item2 = _detailDataOfAllPageWeather.removeAt(oldIndex);
    _detailDataOfAllPageWeather.insert(newIndex, item2);

    notifyListeners();
  }

  void updateCurrentWeatherOfLocation(var geo, {var q = ""}) async {
    var result = await getDetailDataOfPageView(geo.lat, geo.lon, q: q);

    CurrentForeCast currentForeCast = result[0];

    if (currentForeCast.coord?.lat == null) {
      _currentWeatherOfLocations.removeLast();
      _detailDataOfAllPageWeather.removeLast();
      return;
    }

    var lat = currentForeCast.coord?.lat;
    var lon = currentForeCast.coord?.lon;
    var city = currentForeCast.name;

    var res = await dbHelper.insert(lat, lon, city);

    if (res == 0) {
      _currentWeatherOfLocations.removeLast();
      _detailDataOfAllPageWeather.removeLast();
    }

    isLoading = false;
    notifyListeners();
  }

  void deleteCurrentWeatherOfLocation(var index) {
    _currentWeatherOfLocations.removeAt(index);
    _detailDataOfAllPageWeather.removeAt(index);

    notifyListeners();
  }

  Future<dynamic> getDetailDataOfPageView(var lat, var lon,
      {String q = ''}) async {
    String subQuery = '';

    if (lat != null && lon != null) {
      subQuery = "lat=$lat&lon=$lon";
    } else {
      subQuery = "q=$q";
    }

    String apiCurrentForecast =
        'https://api.openweathermap.org/data/2.5/weather?$subQuery&units=metric&lang=vi&appid=${dotenv.env['API_KEY_WEATHER']}';

    String apiHourlyForecast =
        'https://pro.openweathermap.org/data/2.5/forecast/hourly?$subQuery&units=metric&lang=vi&appid=${dotenv.env['API_KEY_WEATHER']}';

    String apiDailyForeCast =
        'https://pro.openweathermap.org/data/2.5/forecast/daily?$subQuery&cnt=7&units=metric&lang=vi&appid=${dotenv.env['API_KEY_WEATHER']}';

    String apiAirPollution =
        "https://api.openweathermap.org/data/2.5/air_pollution?$subQuery&appid=${dotenv.env['API_KEY_WEATHER']}";

    try {
      List<dynamic> result = await Future.wait([
        http.get(Uri.parse(apiCurrentForecast)),
        http.get(Uri.parse(apiHourlyForecast)),
        http.get(Uri.parse(apiDailyForeCast)),
        http.get(Uri.parse(apiAirPollution))
      ]);

      AirPollution airPollution;

      if (q != '') {
        var lat =
            CurrentForeCast.fromJson(jsonDecode(result[0].body)).coord?.lat;
        var lon =
            CurrentForeCast.fromJson(jsonDecode(result[0].body)).coord?.lon;

        var resAirPollution = await http.get(Uri.parse(
            "https://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lon&appid=${dotenv.env['API_KEY_WEATHER']}"));

        airPollution =
            AirPollution.fromJson(jsonDecode(resAirPollution.body)['list'][0]);
      } else {
        airPollution =
            AirPollution.fromJson(jsonDecode(result[3].body)['list'][0]);
      }

      List<dynamic> res = [
        CurrentForeCast.fromJson(jsonDecode(result[0].body)),
        jsonDecode(result[1].body),
        jsonDecode(result[2].body),
        airPollution
      ];

      _detailDataOfAllPageWeather.add([...res]);

      _currentWeatherOfLocations
          .add(CurrentForeCast.fromJson(jsonDecode(result[0].body)));

      notifyListeners();

      return [...res];
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> getDetailDataOfAllPageView() async {
    List<Map<String, dynamic>> data = [];

    data = await dbHelper.queryAllRows();

    int len = data.length;

    List<dynamic> resultsWeather = [];

    for (var i = 0; i < len; i++) {
      resultsWeather
          .add(getDetailDataOfPageView(data[i]['lat'], data[i]['lon']));
    }

    List<dynamic> result = await Future.wait([...resultsWeather]);

    return result;
  }
}
