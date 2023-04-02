import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/Weather.dart';
import 'dart:async';

class WeatherApiClient {
  static const String url =
      "https://api.open-meteo.com/v1/forecast?latitude=21.02&longitude=105.84&hourly=temperature_2m,apparent_temperature,precipitation,weathercode,cloudcover,temperature_80m,uv_index&models=best_match&daily=weathercode,temperature_2m_max,temperature_2m_min,precipitation_sum,precipitation_hours,windspeed_10m_max&current_weather=true&timezone=Asia%2FBangkok";

  Future<Weather> getWeather() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Weather');
    }
  }
}
