import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/Weather.dart';
import 'package:weather_app/models/AirQuality.dart';
import 'dart:async';

class WeatherApiClient {
  static const String urlWeather =
      "https://api.open-meteo.com/v1/forecast?latitude=21.02&longitude=105.84&hourly=temperature_2m,apparent_temperature,precipitation,relativehumidity_2m,windspeed_10m,weathercode,cloudcover,temperature_80m,uv_index&models=best_match&daily=weathercode,temperature_2m_max,temperature_2m_min,precipitation_sum,precipitation_hours,windspeed_10m_max&current_weather=true&timezone=Asia%2FBangkok";

  static const String urlAir =
      "https://air-quality-api.open-meteo.com/v1/air-quality?latitude=21.02&longitude=105.84&hourly=pm10,pm2_5,carbon_monoxide,nitrogen_dioxide,sulphur_dioxide,ozone,dust,uv_index,ammonia";

  Future<Weather> getWeather() async {
    final response = await http.get(Uri.parse(urlWeather));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Weather');
    }
  }

  Future<AirQuality> getAirQuality() async {
    final response = await http.get(Uri.parse(urlAir));

    if (response.statusCode == 200) {
      return AirQuality.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Weather');
    }
  }

//
  Future<Weather> getWeatherLocation(Map<String, dynamic> data) async {
    String lat = data.values.elementAt(1);
    String lng = data.values.elementAt(2);
    String urlWeather2 =
        "https://api.open-meteo.com/v1/forecast?latitude=${lat}&longitude=${lng}&hourly=temperature_2m,apparent_temperature,precipitation,relativehumidity_2m,windspeed_10m,weathercode,cloudcover,temperature_80m,uv_index&models=best_match&daily=weathercode,temperature_2m_max,temperature_2m_min,precipitation_sum,precipitation_hours,windspeed_10m_max&current_weather=true&timezone=Asia%2FBangkok";

    final response = await http.get(Uri.parse(urlWeather2));

    print("urlWeather2 $urlWeather2");

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Weather');
    }
  }
}
