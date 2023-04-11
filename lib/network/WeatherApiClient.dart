import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/CurrentForecast.dart';
import 'package:weather_app/models/AirQuality.dart';
import 'dart:async';

class WeatherApiClient {
  static const String urlAir =
      "https://air-quality-api.open-meteo.com/v1/air-quality?latitude=21.02&longitude=105.84&hourly=pm10,pm2_5,carbon_monoxide,nitrogen_dioxide,sulphur_dioxide,ozone,dust,uv_index,ammonia";

  Future<AirQuality> getAirQuality() async {
    final response = await http.get(Uri.parse(urlAir));

    if (response.statusCode == 200) {
      return AirQuality.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Weather');
    }
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

    List<dynamic> result = await Future.wait([
      http.get(Uri.parse(apiCurrentForecast)),
      http.get(Uri.parse(apiHourlyForecast)),
      http.get(Uri.parse(apiDailyForeCast)),
    ]);

    // CurrentWeather currentWeather = result[0];

    // List<HourlyForeCast> hourlyForeCast = result[1]
    //     .map<HourlyForeCast>((hour) => HourlyForeCast.fromJson(hour))
    //     .toList();

    // List<DailyForeCast> dailyForeCast = result[2]
    //     .map<DailyForeCast>((day) => DailyForeCast.fromJson(day))
    //     .toList();

    return result;
  }

  Future<dynamic> dataForecastCurrent(var lat, var lon, var q) async {
    String subQuery = '';

    if (lat != null && lon != null) {
      subQuery = "lat=$lat&lon=$lon";
    } else {
      subQuery = "q?$q";
    }

    String apiCurrentForecast =
        'https://api.openweathermap.org/data/2.5/weather?$subQuery&units=metric&appid=${dotenv.env['API_KEY_WEATHER']}';

    final result = await http.get(Uri.parse(apiCurrentForecast));

    return CurrentForeCast.fromJson(jsonDecode(result.body));
  }
}
