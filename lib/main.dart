import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/models/AirQuality.dart';
import 'package:weather_app/models/CurrentForecast.dart';
import 'database/database_helper.dart';
import 'location.dart';
import 'package:weather_app/models/Weather2.dart';
import 'package:weather_app/network/WeatherApiClient.dart';
import 'package:weather_app/widget/current_weather.dart';
import 'package:weather_app/widget/daily_weather.dart';
import 'package:weather_app/widget/hourly_weather.dart';
import 'package:weather_app/widget/air_quality.dart';

import 'models/DailyForecast.dart';
import 'models/HourlyForecast.dart';

final dbHelper = DatabaseHelper();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dbHelper.init();
  await dotenv.load(fileName: "lib/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic>? dataWeather;
  CurrentForeCast? currentForeCast;
  List<HourlyForeCast>? hourlyForeCast;
  List<DailyForeCast>? dailyForeCast;

  AirQuality airQuality = new AirQuality();
  var isLoaded = false;

  Future<void> getData() async {
    dataWeather = await WeatherApiClient().dataForecastDetail(null, null);

    airQuality = await WeatherApiClient().getAirQuality();

    currentForeCast =
        CurrentForeCast.fromJson(jsonDecode(dataWeather?[0].body));

    print("dataWeather: ${jsonDecode(dataWeather?[1].body)['list']}");

    hourlyForeCast = jsonDecode(dataWeather?[1].body)['list']
        .map<HourlyForeCast>(
            (hour) => HourlyForeCast.fromJson(hour))
        .toList();

    dailyForeCast = jsonDecode(dataWeather?[2].body)
        .body['list']
        .map<DailyForeCast>((day) => DailyForeCast.fromJson(jsonDecode(day)))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // title: ListTile(
            //   title: Center(
            //       child: Row(children: const [Text('Title'), Icon(Icons.bolt)])),
            //   subtitle: const Center(child: Text('Subtitle')),
            //   onTap: () {},
            // ),
            // elevation: ,
            ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const <Widget>[
              DrawerHeader(child: Text("Weather")),
              buildMenuItem()
            ],
          ),
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  currentWeather(currentForeCast!),
                  const SizedBox(height: 16),
                  hourlyWeather(hourlyForeCast!),
                  const SizedBox(height: 16),
                  dailyWeather(dailyForeCast!),
                  const SizedBox(height: 16),
                  infoWeather(airQuality),
                ],
              ),
            );
          },
        ));
  }
}

// ignore: camel_case_types
class buildMenuItem extends StatelessWidget {
  const buildMenuItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        trailing: const Icon(Icons.arrow_forward_ios),
        title: const Text('Sửa địa điểm'),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const LocationPage();
          }));
        },
      ),
      ListTile(
        trailing: const Icon(Icons.arrow_forward_ios),
        title: const Text('Item 1'),
        onTap: () {},
      ),
      ListTile(
        trailing: const Icon(Icons.arrow_forward_ios),
        title: const Text('Item 1'),
        onTap: () {},
      ),
      ListTile(
        trailing: const Icon(Icons.arrow_forward_ios),
        title: const Text('Vote'),
        onTap: () {},
      ),
    ]);
  }
}
