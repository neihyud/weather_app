import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/CurrentForecast.dart';
import 'dart:async';

class WeatherApiClient {
  Future<dynamic> getDataCurrentWeather(var lat, var lon, { String q = ''}) async {
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
