import 'package:flutter/material.dart';
import 'package:weather_app/widget/AirPollution.dart';
import 'package:weather_app/widget/CurrentWeather.dart';
import 'package:weather_app/widget/DailyWeather.dart';
import 'package:weather_app/widget/HourlyWeather.dart';
import 'package:weather_app/widget/ParamsWeather.dart';

import 'models/AirPollution.dart';
import 'models/CurrentForecast.dart';
import 'models/DailyForecast.dart';
import 'models/HourlyForecast.dart';

class WeatherPageView extends StatefulWidget {
  final dynamic data;

  const WeatherPageView({super.key, required this.data});

  @override
  State<WeatherPageView> createState() => _WeatherPageViewState();
}

class _WeatherPageViewState extends State<WeatherPageView> {
  CurrentForeCast? currentForeCast;
  List<HourlyForeCast>? hourlyForeCast;
  List<DailyForeCast>? dailyForeCast;
  AirPollution? airPollution;

  dynamic timezone;
  dynamic windSpeed;
  dynamic humidity;
  dynamic cloudiness;
  dynamic code = '';
  dynamic temp;
  dynamic location;

  @override
  Widget build(BuildContext context) {
    final dataWeather = widget.data;

    currentForeCast = dataWeather[0];

    windSpeed = currentForeCast?.wind?.speed;

    humidity = currentForeCast?.main?.humidity;

    cloudiness = currentForeCast?.clouds?.all;

    code = currentForeCast?.weather?[0].icon;

    temp = currentForeCast?.main?.temp?.round();

    location = currentForeCast?.name;

    timezone = currentForeCast?.timezone;

    hourlyForeCast = dataWeather[1]['list']
        .map<HourlyForeCast>((hour) => HourlyForeCast.fromJson(hour))
        .toList();

    dailyForeCast = dataWeather[2]['list']
        .map<DailyForeCast>((day) => DailyForeCast.fromJson(day))
        .toList();

    airPollution = dataWeather[3];

    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          currentWeather(code, temp),
          const SizedBox(height: 16),
          paramsWeather(windSpeed, humidity, cloudiness),
          const SizedBox(height: 16),
          hourlyWeather(hourlyForeCast!, timezone),
          const SizedBox(height: 16),
          dailyWeather(dailyForeCast!),
          const SizedBox(height: 16),
          infoAirPollution(airPollution!),
        ],
      ),
    );
  }
}
