import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/CurrentForecast.dart';
import 'dart:async';

class WeatherApiClient {
  Future<dynamic> dataForecastDetail(var lat, var lon) async {
    if (lat == null || lon == null) {
      lat = '21';
      lon = '105';
    }

    String apiCurrentForecast =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&lang=vi&lang=viappid=${dotenv.env['API_KEY_WEATHER']}';

    String apiHourlyForecast =
        'https://pro.openweathermap.org/data/2.5/forecast/hourly?lat=$lat&lon=$lon&units=metric&lang=vi&appid=${dotenv.env['API_KEY_WEATHER']}';

    String apiDailyForeCast =
        'https://pro.openweathermap.org/data/2.5/forecast/daily?lat=$lat&lon=$lon&cnt=7&units=metric&lang=vi&appid=${dotenv.env['API_KEY_WEATHER']}';

    List<dynamic> result = await Future.wait([
      http.get(Uri.parse(apiCurrentForecast)),
      http.get(Uri.parse(apiHourlyForecast)),
      http.get(Uri.parse(apiDailyForeCast)),
    ]);

    return result;
  }

  Future<dynamic> dataForecastCurrent(var lat, var lon, var q) async {
    String subQuery = '';

    if (lat != null && lon != null) {
      subQuery = "lat=$lat&lon=$lon";
    } else {
      subQuery = "q=$q";
    }

    String apiCurrentForecast =
        'https://api.openweathermap.org/data/2.5/weather?$subQuery&units=metric&lang=vi&appid=${dotenv.env['API_KEY_WEATHER']}';

    final result = await http.get(Uri.parse(apiCurrentForecast));

    return CurrentForeCast.fromJson(jsonDecode(result.body));
  }
}
