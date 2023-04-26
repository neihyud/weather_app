import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/models/CurrentForecast.dart';
import 'package:weather_app/provider/WeatherProvider.dart';
import 'package:weather_app/models/AirPollution.dart';
import 'package:weather_app/widget/ParamsWeather.dart';
import 'database/database_helper.dart';
import 'location.dart';
import 'package:weather_app/widget/CurrentWeather.dart';
import 'package:weather_app/widget/DailyWeather.dart';
import 'package:weather_app/widget/HourlyWeather.dart';
import 'package:weather_app/widget/AirPollution.dart';

import 'models/DailyForecast.dart';
import 'models/HourlyForecast.dart';

import 'package:home_widget/home_widget.dart';

final dbHelper = DatabaseHelper();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dbHelper.init();
  await dotenv.load(fileName: "lib/.env");

  HomeWidget.registerBackgroundCallback(backgroundCallback);
  runApp(const MyApp());
}

//
Future<void> backgroundCallback(Uri? uri) async {
  if (uri?.host == 'updatecounter') {
    int counter = 0;
    await HomeWidget.getWidgetData<int>('_counter', defaultValue: 0)
        .then((value) {
      counter = value!;
      counter++;
    });
    await HomeWidget.saveWidgetData<int>('_counter', counter);
    await HomeWidget.updateWidget(
        //this must the class name used in .Kt
        name: 'HomeScreenWidgetProvider',
        iOSName: 'HomeScreenWidgetProvider');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => WeatherProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: const MyHomePage(title: 'Home'),
      ),
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
  CurrentForeCast? currentForeCast;
  List<HourlyForeCast>? hourlyForeCast;
  List<DailyForeCast>? dailyForeCast;
  AirPollution? airPollution;

  dynamic windSpeed;
  dynamic humidity;
  dynamic cloudiness;
  dynamic des;
  dynamic temp;
  dynamic location;

  bool _isLoading = false;

  void loadData() async {
    await HomeWidget.getWidgetData<int>('_counter', defaultValue: 0)
        .then((value) {
      // _counter = value!;
    });

    HomeWidget.getWidgetData<int>('_location', defaultValue: 25).then((value) {
      // _counter = value!;
    });

    HomeWidget.getWidgetData<int>('_temp', defaultValue: 0).then((value) {
      // _counter = value!;
    });

    setState(() {});
  }

  Future<void> updateAppWidget() async {
    await HomeWidget.saveWidgetData<String>('_location', currentForeCast?.name);
    await HomeWidget.saveWidgetData<String>('_temp', temp);

    await HomeWidget.saveWidgetData<String>(
        '_img', "a${currentForeCast?.weather?[0].icon}");
    await HomeWidget.updateWidget(
        name: 'HomeScreenWidgetProvider', iOSName: 'HomeScreenWidgetProvider');
  }

  void _incrementCounter() {
    setState(() {
      // _counter++;
    });
    updateAppWidget();
  }

  @override
  void initState() {
    // HomeWidget.widgetClicked.listen((Uri? uri) => loadData());
    // loadData(); // This will load data from widget every time app is opened

    setState(() {
      _isLoading = true;
    });
    Provider.of<WeatherProvider>(context, listen: false)
        .dataForecastDetail(null, null)
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });

    Provider.of<WeatherProvider>(context, listen: false)
        .savedLocationForecast();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context);
    final dataWeather = weatherData.getDataForeCastDetail;

    if (!_isLoading) {
      currentForeCast =
          CurrentForeCast.fromJson(jsonDecode(dataWeather[0].body));

      windSpeed = currentForeCast?.wind?.speed;

      humidity = currentForeCast?.main?.humidity;

      cloudiness = currentForeCast?.clouds?.all;

      des = currentForeCast?.weather?[0].main;

      temp = currentForeCast?.main?.temp?.round();

      location = currentForeCast?.name;

      hourlyForeCast = jsonDecode(dataWeather[1].body)['list']
          .map<HourlyForeCast>((hour) => HourlyForeCast.fromJson(hour))
          .toList();

      dailyForeCast = jsonDecode(dataWeather[2].body)['list']
          .map<DailyForeCast>((day) => DailyForeCast.fromJson(day))
          .toList();

      airPollution =
          AirPollution.fromJson(jsonDecode(dataWeather[3].body)['list'][0]);
    }

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment(0.8, 1),
        colors: <Color>[
          // Color(0xfffd5e53),
          Color.fromARGB(255, 94, 131, 186),
          Color.fromARGB(200, 136, 161, 202),
          // Color(0xff1f005c),
          // Color(0xff5b0060),
          // Color(0xff870160),
          // Color(0xffac255e),
          // Color(0xffca485c),
          // Color(0xffe16b5c),
          // Color(0xfff39060),
          // Color(0xffffb56b),
        ],
        tileMode: TileMode.mirror,
      )),
      child: Scaffold(
          // extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          drawer: Drawer(
            // backgroundColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListView(
              padding: EdgeInsets.zero,
              children: const <Widget>[
                DrawerHeader(child: Text("Weather")),
                buildMenuItem()
              ],
            ),
          ),
          body: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      currentWeather(des, temp, location),
                      const SizedBox(height: 16),
                      paramsWeather(windSpeed, humidity, cloudiness),
                      // const SizedBox(height: 16),
                      // const Text(
                      //   "Today",
                      //   style: TextStyle(
                      //       fontSize: 25,
                      //       fontWeight: FontWeight.w700,
                      //       color: Colors.white70),
                      // ),
                      const SizedBox(height: 16),
                      hourlyWeather(hourlyForeCast!),
                      const SizedBox(height: 16),
                      dailyWeather(dailyForeCast!),
                      const SizedBox(height: 16),
                      infoAirPollution(airPollution!),
                    ],
                  ),
                )),
    );
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
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const LocationPage();
          }));
        },
      ),
      ListTile(
        trailing: const Icon(Icons.arrow_forward_ios),
        title: const Text('Vote'),
        onTap: () {},
      ),
    ]);
  }
}
