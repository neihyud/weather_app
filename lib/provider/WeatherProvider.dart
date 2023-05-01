import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:home_widget/home_widget.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/helper/type_code.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/models/CurrentForecast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/AirPollution.dart';

class WeatherProvider with ChangeNotifier {
  bool isLoading = false;

  List<dynamic> _detailDataOfAllPageWeather = [];
  List<dynamic> get getDetailDataOfAllPageWeather {
    return [..._detailDataOfAllPageWeather];
  }

  List<dynamic> _currentWeatherOfLocations = [];
  List<dynamic> get getCurrentWeatherOfLocations {
    return [..._currentWeatherOfLocations];
  }

  List<String> paramsLocation = [];

  getParamsLocation() {
    return [...paramsLocation];
  }

  void loading() {
    isLoading = true;
    notifyListeners();
  }

  void turnOffLoading() {
    isLoading = false;
    notifyListeners();
  }

  addParamsCurrentToSF(int index) async {
    CurrentForeCast currentForeCast = _currentWeatherOfLocations[index];

    var lat = currentForeCast.coord?.lat;
    var lon = currentForeCast.coord?.lon;
    String name = currentForeCast.name.toString();

    SharedPreferences.getInstance()
        .then((pref) => pref.setStringList('current', ["$lat", "$lon", name]));

    paramsLocation = ["$lat", "$lon", name];

    updateHomeWidget(currentForeCast);

    notifyListeners();
  }

  void updateHomeWidget(CurrentForeCast currentForeCast) async {
    String name = currentForeCast.name.toString();
    var temp = currentForeCast.main?.temp?.round();

    int dt = currentForeCast.dt! + currentForeCast.timezone! - 25200;
    dynamic code = currentForeCast.weather?[0].icon;
    String type = getTypeCode(code, dt);

    HomeWidget.saveWidgetData<String>('_location', name);
    HomeWidget.saveWidgetData<String>('_temp', "$temp°");
    HomeWidget.saveWidgetData<String>('_img', "a$type");

    HomeWidget.updateWidget(name: 'HomeScreenWidgetProvider');
  }

  changeIndexCurrentLocationsWeather(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final CurrentForeCast currentForeCast =
        _currentWeatherOfLocations.removeAt(oldIndex);
    _currentWeatherOfLocations.insert(newIndex, currentForeCast);

    final dataPageWeather = _detailDataOfAllPageWeather.removeAt(oldIndex);
    _detailDataOfAllPageWeather.insert(newIndex, dataPageWeather);

    SharedPreferences pref = await SharedPreferences.getInstance();

    List<String>? cities = pref.getStringList('orderPlace');
    final city = cities?.removeAt(oldIndex);
    cities?.insert(newIndex, city!);
    pref.setStringList('orderPlace', [...?cities]);

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
    } else {
      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? cities = pref.getStringList('orderPlace');
      cities?.add('${_currentWeatherOfLocations.last.name}');
      await pref.setStringList('orderPlace', [...?cities]);
    }

    isLoading = false;
    notifyListeners();
  }

  void deleteCurrentWeatherOfLocation(var index) async {
    _currentWeatherOfLocations.removeAt(index);
    _detailDataOfAllPageWeather.removeAt(index);

    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? cities = pref.getStringList('orderPlace');
    cities?.removeAt(index);
    await pref.setStringList('orderPlace', [...?cities]);

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
    SharedPreferences pref = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> data = [];

    data = await dbHelper.queryAllRows();

    if (data.isEmpty) {
      await dbHelper.insert(35.6895, 139.6917, "Tokyo");
      data = [
        {'lat': 35.6895, 'lon': 139.6917, 'city': 'Tokyo'}
      ];
      pref.setStringList('current', ['35.6895', '139.6917', 'Tokyo']);
      pref.setStringList('orderPlace', ['Tokyo']);
    }

    int len = data.length;

    List<dynamic> req = [];

    List<String> cities = [];

    for (var i = 0; i < len; i++) {
      cities.add(data[i]['city']);
      req.add(getDetailDataOfPageView(data[i]['lat'], data[i]['lon']));
    }

    List<dynamic> result = await Future.wait([...req]);

    if (pref.getStringList('orderPlace')?.length == data.length) {
      cities = [...?pref.getStringList('orderPlace')];
    } else {
      await pref.setStringList('orderPlace', [...cities]);
    }

    if (pref.containsKey('current')) {
      paramsLocation = [...?pref.getStringList('current')];
    } else {
      paramsLocation = ['35.6895', '139.6917', 'Tokyo'];
    }

    List<dynamic> currentWeatherOfLocationsTemp = List.filled(len, null);
    List<dynamic> detailDataOfAllPageWeatherTemp = List.filled(len, null);
    for (var oldIndex = 0; oldIndex < cities.length; oldIndex++) {
      if (paramsLocation[2] == cities[oldIndex]) {
        await pref.setInt('currentIndex', oldIndex);
      }

      String? name = _currentWeatherOfLocations[oldIndex].name;
      int newIndex = cities.indexOf(name!);

      if (newIndex == -1) continue;

      currentWeatherOfLocationsTemp[newIndex] =
          _currentWeatherOfLocations[oldIndex];

      detailDataOfAllPageWeatherTemp[newIndex] =
          _detailDataOfAllPageWeather[oldIndex];
    }

    _currentWeatherOfLocations = [...currentWeatherOfLocationsTemp];
    _detailDataOfAllPageWeather = [...detailDataOfAllPageWeatherTemp];

    // notifyListeners();

    return _detailDataOfAllPageWeather;
  }
}
